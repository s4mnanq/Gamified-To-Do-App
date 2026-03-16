import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/constants/storage_keys.dart';
import 'package:gamified_todo_app/core/services/references_service.dart';
import 'package:gamified_todo_app/core/utils/logger.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  late final PageController pageController;
  final pageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();

    debounce(pageIndex, (_) {
      AppLogger.data('Onboarding Page Index Changed: ${pageIndex.value}');
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  void skipOnboarding() {
    AppLogger.data('Onboarding skipped by user.');
    goToNextScreen();
  }

  void goToNextPage() {
    if (pageIndex.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      AppLogger.info('User completed onboarding.');
      goToNextScreen();
    }
  }

  void goToNextScreen() {
    if (!Get.isRegistered<ReferencesService>()) {
      Get.put<ReferencesService>(ReferencesService());
    }

    final referencesService = Get.find<ReferencesService>();
    referencesService.setReference(StorageKeys.onboardingCompleted, true);

    Get.offAllNamed(AppRoutes.authGate);
  }
}
