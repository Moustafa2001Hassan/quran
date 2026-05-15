import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/core/theme/app_typography.dart';
import 'package:quran_journey/features/onboarding/presentation/models/onboarding_slide_data.dart';

class OnboardingSlidePanel extends StatelessWidget {
  const OnboardingSlidePanel({
    super.key,
    required this.data,
    required this.pageIndex,
  });

  final OnboardingSlideData data;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = context.qjPalette;
    final radii = context.qjRadii;

    final iconBox = Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            palette.gold.withValues(alpha: 0.35),
            scheme.primary.withValues(alpha: 0.55),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: palette.gold.withValues(alpha: 0.25),
            blurRadius: 28,
            spreadRadius: -4,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Icon(data.icon, size: 48, color: scheme.onPrimary),
    )
        .animate(key: ValueKey<int>(pageIndex))
        .scale(
          duration: 520.ms,
          curve: Curves.easeOutCubic,
          begin: const Offset(0.88, 0.88),
          end: const Offset(1, 1),
        );

    final arabic = Text(
      data.arabic,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      style: AppTypography.arabicVerse(
        scheme.onSurface,
        fontSize: MediaQuery.sizeOf(context).width >= 600 ? 32 : 26,
      ),
    )
        .animate(key: ValueKey<String>('${pageIndex}_ar'))
        .fadeIn(duration: 450.ms, delay: 90.ms, curve: Curves.easeOut)
        .slideY(begin: 0.12, end: 0, duration: 520.ms, curve: Curves.easeOutCubic);

    final title = Text(
      data.title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            letterSpacing: -0.2,
            height: 1.15,
          ),
    )
        .animate(key: ValueKey<String>('${pageIndex}_ti'))
        .fadeIn(duration: 420.ms, delay: 140.ms)
        .slideY(begin: 0.1, end: 0, duration: 480.ms, curve: Curves.easeOutCubic);

    final subtitle = Text(
      data.subtitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.55,
            color: scheme.onSurfaceVariant,
          ),
    )
        .animate(key: ValueKey<String>('${pageIndex}_su'))
        .fadeIn(duration: 480.ms, delay: 220.ms)
        .slideY(begin: 0.08, end: 0, duration: 520.ms, curve: Curves.easeOutCubic);

    final divider = Container(
      height: 3,
      width: 56,
      decoration: BoxDecoration(
        borderRadius: radii.borderSm(),
        gradient: LinearGradient(
          colors: [
            palette.goldMuted.withValues(alpha: 0.2),
            palette.gold,
            palette.goldMuted.withValues(alpha: 0.2),
          ],
        ),
      ),
    )
        .animate(key: ValueKey<String>('${pageIndex}_div'))
        .scaleX(duration: 600.ms, delay: 180.ms, begin: 0, end: 1, curve: Curves.easeOutCubic);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: OnboardingSlideData.contentPadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          iconBox,
          SizedBox(height: AppSpacing.xl + AppSpacing.sm),
          divider,
          SizedBox(height: AppSpacing.xl),
          arabic,
          SizedBox(height: AppSpacing.lg),
          title,
          SizedBox(height: AppSpacing.md),
          subtitle,
        ],
      ),
    ),
    );
  }
}
