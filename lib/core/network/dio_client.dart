import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gamified_todo_app/core/services/token_storage.dart';
import 'package:gamified_todo_app/env/app_config.dart';
import 'package:get/get.dart';

import 'dio_logger.dart';
import '../errors/api_exception.dart';
import '../../repositories/auth_repository.dart';
import '../constants/api_constants.dart';
import '../../routes/app_routes.dart';

class DioClient extends GetxService {
  late final Dio dio;

  Future<void>? _refreshFuture;

  Future<DioClient> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add debug-only logger
    if (kDebugMode) dio.interceptors.add(DioLogger());

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = Get.isRegistered<TokenStorage>()
              ? Get.find<TokenStorage>()
              : null;
          final token = storage == null
              ? null
              : await storage.readAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          final path = error.requestOptions.path;

          final isAuthEndpoint =
              path.contains(ApiEndpoints.login) ||
              path.contains(ApiEndpoints.refreshToken);

          if (status == 401 && !isAuthEndpoint) {
            final ok = await _tryRefreshToken();
            if (ok) {
              final storage = Get.find<TokenStorage>();
              final newToken = await storage.readAccessToken();
              final requestOptions = error.requestOptions;
              if (newToken != null && newToken.isNotEmpty) {
                requestOptions.headers['Authorization'] = 'Bearer $newToken';
              }

              try {
                final response = await dio.fetch(requestOptions);
                handler.resolve(response);
                return;
              } catch (e) {
                handler.next(error);
                return;
              }
            }

            if (Get.currentRoute != AppRoutes.login) {
              Get.offAllNamed(AppRoutes.login);
            }
          }

          handler.next(error);
        },
      ),
    );

    // Global interceptor to map backend errors
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final data = response.data;
          if (data is Map && data['success'] == false) {
            handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                type: DioExceptionType.badResponse,
                error: ApiException(
                  message: data['message'] ?? 'Unknown error',
                  status: data['status'] ?? response.statusCode ?? 500,
                  error: data['error'],
                  details: data['details'],
                ),
              ),
            );
            return;
          }
          handler.next(response);
        },
        onError: (error, handler) {
          final res = error.response;
          if (res?.data is Map) {
            final data = res!.data;
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                response: res,
                error: ApiException(
                  message: data['message'] ?? 'Request failed',
                  status: data['status'] ?? res.statusCode ?? 500,
                  error: data['error'],
                  details: data['details'],
                ),
                type: error.type,
              ),
            );
            return;
          }
          handler.next(error);
        },
      ),
    );

    return this;
  }

  Future<bool> _tryRefreshToken() async {
    if (_refreshFuture != null) {
      await _refreshFuture;
      final token = await Get.find<TokenStorage>().readAccessToken();
      return token != null && token.isNotEmpty;
    }

    final completer = Completer<void>();
    _refreshFuture = completer.future;

    try {
      final storage = Get.find<TokenStorage>();
      final refreshToken = await storage.readRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await storage.clear();
        return false;
      }

      final authRepo = Get.isRegistered<AuthRepository>()
          ? Get.find<AuthRepository>()
          : AuthRepository();
      if (!Get.isRegistered<AuthRepository>()) {
        Get.put(authRepo);
      }

      final res = await authRepo.refresh(refreshToken);
      final data = res.data;
      if (data is Map<String, dynamic>) {
        final access = (data['accessToken'] ?? data['access_token'])
            ?.toString();
        final refresh = (data['refreshToken'] ?? data['refresh_token'])
            ?.toString();
        if (access != null && access.isNotEmpty) {
          await storage.writeTokens(accessToken: access, refreshToken: refresh);
          return true;
        }
      }

      return false;
    } on DioException catch (e) {
      final storage = Get.find<TokenStorage>();
      final api = e.error;
      if (api is ApiException && api.status == 401) {
        await storage.clear();
      }
      return false;
    } on ApiException catch (_) {
      await Get.find<TokenStorage>().clear();
      return false;
    } finally {
      completer.complete();
      _refreshFuture = null;
    }
  }
}
