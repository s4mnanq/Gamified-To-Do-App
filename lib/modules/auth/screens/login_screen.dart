import 'package:flutter/material.dart';
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

                    CustomizeTextFormField(
                      controller: controller.passwordController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      validator: controller.validatePassword,
                      obscureText: true,
                    ),
                  ],
                ),
              ).marginOnly(bottom: 72),

              CustomizeButton(
                onTap: controller.login,
                buttonText: 'Login',
              ).marginOnly(bottom: 16),
            ],
          ),
        ),
      ),
    );
  }
}
