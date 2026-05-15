import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.count,
    required this.page,
  });

  final int count;
  final double page;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<QuranJourneyPalette>() ?? QuranJourneyPalette.light();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final distance = (page - i).abs().clamp(0.0, 1.0);
        final expanded = 1.0 - distance;
        final width = 8.0 + expanded * 28.0;
        final height = 8.0 + expanded * 2.0;
        final color = Color.lerp(
          scheme.outline.withValues(alpha: 0.35),
          palette.gold,
          expanded,
        )!;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: color,
            boxShadow: expanded > 0.65
                ? [
                    BoxShadow(
                      color: palette.gold.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
