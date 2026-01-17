import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/constants/app_state.dart';
import 'package:gamified_todo_app/modules/auth/controllers/login_controller.dart';
import 'package:gamified_todo_app/widgets/customize_button.dart';
import 'package:gamified_todo_app/widgets/customize_text_form_field.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(
                'Welcome Back!',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              ).marginOnly(bottom: 8),

              Text(
                'Please login to continue',
                style: context.textTheme.bodyMedium,
              ).marginOnly(bottom: 48),

              Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    CustomizeTextFormField(
                      controller: controller.emailController,
                      hintText: 'email@example.com',
                      labelText: 'Email',
                      validator: controller.validateEmail,
                    ).marginOnly(bottom: 24),

                    Obx(() {
                      final isObscured = controller.isObscured.value;
                      return CustomizeTextFormField(
                        controller: controller.passwordController,
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        validator: controller.validatePassword,
                        obscureText: isObscured,
                        suffixIcon: _buildSuffixIcon(isObscured),
                      );
                    }),
                  ],
                ),
              ).marginOnly(bottom: 72),

              _buildLoginButton(context).marginOnly(bottom: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomizeButton(
      onTap: () => controller.login(context),
      buttonText: 'Login',
    );
  }

  // Widget _buildLoginButton(BuildContext context) {
  //   return Obx(() {
  //     final isLoading = controller.loginState.value.isLoading;
  //     return CustomizeButton(
  //       onTap: () => controller.login(context),
  //       buttonText: 'Login',
  //       isLoading: isLoading,
  //     );
  //   });
  // }

  Widget _buildSuffixIcon(bool isObscured) {
    return GestureDetector(
      onTap: controller.togglePasswordVisibility,
      child: Icon(
        isObscured ? Icons.visibility_off : Icons.visibility,
        color: Get.context?.theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }
}
