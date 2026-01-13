import 'package:dio/dio.dart';
import 'package:gamified_todo_app/core/constants/api_constants.dart';
import 'package:gamified_todo_app/core/errors/api_exception.dart';
import 'package:gamified_todo_app/core/network/dio_client.dart';
import 'package:get/get.dart';
import '../models/api_response.dart';

class AuthRepository {
  final DioClient _dioClient = Get.find<DioClient>();

  Future<ApiResponse<dynamic>> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }

  Future<ApiResponse<dynamic>> me() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.me);
      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }

  Future<ApiResponse<dynamic>> refresh(String refreshToken) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      return ApiResponse.fromJson(response.data, null);
    } on DioException catch (e) {
      if (e.error is ApiException) throw e.error!;
      rethrow;
    }
  }
}
