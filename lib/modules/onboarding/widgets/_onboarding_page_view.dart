part of '../screens/onboarding_screen.dart';

class _OnboardingPageView extends StatelessWidget {
  final PageController _pageController;
  final RxInt pageIndex;

  const _OnboardingPageView({
    required PageController pageController,
    required this.pageIndex,
  }) : _pageController = pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        pageIndex.value = index;
      },
      children: [
        _buildPage1(context: context),
        _buildPage2(context: context),
        _buildPage3(context: context),
      ],
    );
  }

  Widget _buildPage1({required BuildContext context}) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        Flexible(
          flex: 6,
          child: Image.asset(Assets.images.onboarding.img1.path, fit: .contain),
        ),

        _buildOnboardingDetail(
          context: context,
          title: 'Welcome to Gamified To-Do App',
          description:
              'Transform tasks into quests and earn rewards as you conquer your goals.',
        ),
      ],
    );
  }

  Widget _buildPage2({required BuildContext context}) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        Flexible(
          flex: 6,
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              Text(
                'LEVEL UP!',
                style: context.textTheme.displayLarge?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              ).marginOnly(bottom: 16),

              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * 0.8,
                    height: 48,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     context.theme.colorScheme.primary,
                      //     context.theme.colorScheme.secondary.withValues(
                      //       alpha: 0.3,
                      //     ),
                      //   ],
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: Container(
                            color: context.theme.colorScheme.secondary
                                .withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).marginOnly(bottom: 16),

              Text(
                'XP + 250',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        _buildOnboardingDetail(
          context: context,
          title: 'Your streak fuels your power.',
          description: 'Build daily habits and maintain your winning streak',
        ),
      ],
    );
  }

  Widget _buildPage3({required BuildContext context}) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        Flexible(
          flex: 6,
          child: Image.asset(Assets.images.onboarding.img2.path, fit: .contain),
        ),

        _buildOnboardingDetail(
          context: context,
          title: 'Your streak fuels your power.',
          description: 'Build daily habits and maintain your winning streak',
        ),
      ],
    );
  }

  Widget _buildOnboardingDetail({
    required String title,
    required String description,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        Text(
          title,
          textAlign: .center,
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.theme.colorScheme.secondary,
          ),
        ).marginOnly(bottom: 16),
        Text(
          description,
          textAlign: .center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
