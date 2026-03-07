import 'package:gamified_todo_app/core/constants/app_state.dart';
import 'package:gamified_todo_app/core/errors/api_exception.dart';
import 'package:gamified_todo_app/core/errors/error_handler.dart';
import 'package:gamified_todo_app/core/utils/logger.dart';
import 'package:gamified_todo_app/core/services/token_storage.dart';
import 'package:gamified_todo_app/core/utils/snackbar_utils.dart';
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

  final loginState = AppState.initial.obs;

  final isObscured = true.obs;

  final passwordError = Rxn<String>(null);

  @override
  void onInit() {
    super.onInit();
    loginFormKey = GlobalKey<FormState>();
    passwordController.addListener(_clearPasswordError);
  }

  @override
  void onClose() {
    passwordController.removeListener(_clearPasswordError);
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _clearPasswordError() {
    if (passwordError.value != null) {
      passwordError.value = null;
    }
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
    if (passwordError.value != null) {
      return passwordError.value;
    }

    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  Future<void> login(BuildContext context) async {
    passwordError.value = null;

    if (loginFormKey.currentState?.validate() ?? false) {
      final email = emailController.text.trim();
      final password = passwordController.text;

      try {
        loginState.value = AppState.loading;

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

            loginState.value = AppState.loaded;

            if (context.mounted) {
              SnackbarUtils.showSuccess(context, message: 'Welcome back!');
            }

            Get.offAllNamed(AppRoutes.main);
            return;
          }
        }

        AppLogger.error(
          'Login succeeded but tokens missing',
          tag: 'LoginController',
        );
        loginState.value = AppState.error;
      } catch (e) {
        loginState.value = AppState.error;
        AppLogger.error(e.toString(), tag: 'LoginController');

        if (context.mounted) {
          if (e is ApiException) {
            _handleApiException(e, context);
          } else {
            SnackbarUtils.showError(
              context,
              message: 'An unexpected error occurred. Please try again.',
            );
          }
        }
      }
    }
  }

  void _handleApiException(ApiException exception, BuildContext context) {
    if (exception.status == 404) {
      passwordError.value = 'Invalid email or password';

      loginFormKey.currentState?.validate();

      return;
    }

    if (ApiErrorHandler.hasDetails(exception)) {
      bool hasFieldErrors = false;

      final passwordErr = ApiErrorHandler.getDetail(exception, 'password');

      if (passwordErr != null) {
        passwordError.value = passwordErr;
        hasFieldErrors = true;
      }

      if (hasFieldErrors) {
        loginFormKey.currentState?.validate();
        return;
      }
    }

    final message = ApiErrorHandler.getErrorMessage(exception);
    SnackbarUtils.showError(context, message: message);
  }

  void togglePasswordVisibility() {
    isObscured.value = !isObscured.value;
  }
}
