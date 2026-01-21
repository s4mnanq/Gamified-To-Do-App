import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/constants/storage_keys.dart';
import 'package:gamified_todo_app/core/services/references_service.dart';
import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../core/services/token_storage.dart';
import '../../../repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class AuthGateScreen extends StatefulWidget {
  const AuthGateScreen({super.key});

  @override
  State<AuthGateScreen> createState() => _AuthGateScreenState();
}

class _AuthGateScreenState extends State<AuthGateScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ReferencesService());
    Get.lazyPut(() => TokenStorage());
    Get.lazyPut(() => AuthRepository());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    if (_navigated) return;
    final referencesService = Get.find<ReferencesService>();
    final isOnboardingCompleted =
        await referencesService.getBoolReference(
          StorageKeys.onboardingCompleted,
        ) ??
        false;

    if (isOnboardingCompleted == false) {
      _navigated = true;
      if (mounted) {
        Get.offAllNamed(AppRoutes.onboarding);
      }
      return;
    }

    final storage = Get.find<TokenStorage>();
    final accessToken = await storage.readAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      _navigated = true;
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
      return;
    }

    try {
      await Get.find<AuthRepository>().me();
      _navigated = true;
      if (mounted) {
        Get.offAllNamed(AppRoutes.main);
      }
    } on ApiException {
      await storage.clear();
      _navigated = true;
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (_) {
      await storage.clear();
      _navigated = true;
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
