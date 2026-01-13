import 'package:gamified_todo_app/core/utils/logger.dart';
import 'package:gamified_todo_app/core/services/token_storage.dart';
import 'package:gamified_todo_app/repositories/auth_repository.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final TokenStorage _tokenStorage = Get.find<TokenStorage>();

  late final GlobalKey<FormState> loginFormKey;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loginFormKey = GlobalKey<FormState>();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  Future<void> login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        final res = await _authRepository.login(email, password);
        final data = res.data;
        if (data is Map<String, dynamic>) {
          final access =
              (data['accessToken'] ?? data['access_token'] ?? data['token'])
                  ?.toString();
          final refresh = (data['refreshToken'] ?? data['refresh_token'])
              ?.toString();

          if (access != null && access.isNotEmpty) {
            await _tokenStorage.writeTokens(
              accessToken: access,
              refreshToken: refresh,
            );
            Get.offAllNamed(AppRoutes.main);
            return;
          }
        }

        AppLogger.error(
          'Login succeeded but tokens missing',
          tag: 'LoginController',
        );
      } catch (e) {
        AppLogger.error(e.toString(), tag: 'LoginController');
      }
    }
  }
}
