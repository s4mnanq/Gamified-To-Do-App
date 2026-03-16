import 'package:flutter/material.dart';
import 'package:gamified_todo_app/gen/assets.gen.dart';
import 'package:gamified_todo_app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:gamified_todo_app/widgets/customize_button.dart';
import 'package:get/get.dart';

part '../widgets/_onboarding_page_view.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              Align(
                alignment: .topRight,
                child: GestureDetector(
                  onTap: controller.skipOnboarding,
                  child: Padding(
                    padding: const .symmetric(vertical: 8, horizontal: 16),
                    child: Obx(() {
                      final isLastPage = controller.pageIndex.value == 2;
                      return Visibility(
                        visible: !isLastPage,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Text(
                          'Skip',
                          style: context.textTheme.titleSmall,
                        ),
                      );
                    }),
                  ),
                ),
              ).marginOnly(bottom: 8),

              Expanded(
                child: _OnboardingPageView(
                  pageController: controller.pageController,
                  pageIndex: controller.pageIndex,
                ).marginOnly(bottom: 16),
              ),

              SizedBox(
                height: 4,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: .horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final isActive = controller.pageIndex.value == index;
                      return AnimatedContainer(
                        width: isActive ? 46 : 32,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isActive
                              ? context.theme.colorScheme.primary
                              : context.theme.colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    });
                  },
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemCount: 3,
                ),
              ),

              Obx(() {
                final isLastPage = controller.pageIndex.value == 2;
                return CustomizeButton(
                  onTap: controller.goToNextPage,
                  buttonText: isLastPage ? 'Get Started' : 'Next',
                ).marginSymmetric(vertical: 24);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
