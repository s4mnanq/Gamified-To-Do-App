import 'package:flutter/material.dart';
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
    Future.microtask(_checkAuthAndNavigate);
  }

  Future<void> _checkAuthAndNavigate() async {
    if (_navigated) return;
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
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
