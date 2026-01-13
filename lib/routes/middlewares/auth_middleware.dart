import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/errors/api_exception.dart';
import '../../core/services/token_storage.dart';
import '../../repositories/auth_repository.dart';
import '../app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    _checkAuth();
    return super.onPageCalled(page);
  }

  Future<void> _checkAuth() async {
    final storage = Get.find<TokenStorage>();
    final accessToken = await storage.readAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    try {
      await Get.find<AuthRepository>().me();
    } on ApiException {
      await storage.clear();
      Get.offAllNamed(AppRoutes.login);
    } catch (_) {
      await storage.clear();
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
