import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/features/onboarding/presentation/models/onboarding_slide_data.dart';
import 'package:quran_journey/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:quran_journey/features/onboarding/presentation/widgets/islamic_lattice_background.dart';
import 'package:quran_journey/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:quran_journey/features/onboarding/presentation/widgets/onboarding_slide_panel.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _roundedIndex = 0;
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final p = _pageController.page ?? _pageController.initialPage.toDouble();
    setState(() {
      _page = p;
      _roundedIndex = p.round();
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_handleScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _complete() {
    ref.read(onboardingCompleteProvider.notifier).complete();
  }

  void _next() {
    if (_roundedIndex >= OnboardingSlideData.count - 1) {
      _complete();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
    );
  }

  void _skip() => _complete();

  @override
  Widget build(BuildContext context) {
    final palette = context.qjPalette;
    final scheme = Theme.of(context).colorScheme;
    final isLast = _roundedIndex >= OnboardingSlideData.count - 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: IslamicLatticeBackground(
              palette: palette,
              page: _page,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quran Journey',
                        style: AppStyles.wordmark(context),
                      ),
                      TextButton(
                        onPressed: _skip,
                        child: const Text('Skip'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: OnboardingSlideData.count,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OnboardingSlidePanel(
                        data: OnboardingSlideData.slides[index],
                        pageIndex: index,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      OnboardingPageIndicator(
                        count: OnboardingSlideData.count,
                        page: _page,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        children: [
                          if (_roundedIndex > 0)
                            TextButton(
                              onPressed: () => _pageController.previousPage(
                                duration: const Duration(milliseconds: 480),
                                curve: Curves.easeOutCubic,
                              ),
                              child: const Text('Back'),
                            )
                          else
                            const SizedBox(width: 72),
                          const Spacer(),
                          FilledButton.icon(
                            onPressed: _next,
                            icon: Icon(isLast ? Icons.check_rounded : Icons.arrow_forward_rounded),
                            label: Text(isLast ? 'Begin' : 'Next'),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(148, 52),
                              backgroundColor: scheme.primary,
                              foregroundColor: scheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
