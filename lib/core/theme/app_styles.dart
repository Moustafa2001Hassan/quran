import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_typography.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';
import 'package:quran_journey/core/theme/quran_journey_radii.dart';

extension QuranJourneyThemeX on BuildContext {
  QuranJourneyPalette get qjPalette =>
      Theme.of(this).extension<QuranJourneyPalette>() ?? QuranJourneyPalette.light();

  QuranJourneyRadii get qjRadii =>
      Theme.of(this).extension<QuranJourneyRadii>() ?? QuranJourneyRadii.standard;

  TextTheme get text => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;
}

/// Reusable [BoxDecoration]s aligned with the Islamic palette.
abstract final class AppDecorations {
  static BoxDecoration verseCard(BuildContext context) {
    final p = context.qjPalette;
    final r = context.qjRadii;
    return BoxDecoration(
      color: p.verseSurface,
      borderRadius: r.borderLg(),
      border: Border.all(color: p.verseBorder.withValues(alpha: 0.65)),
      boxShadow: [
        BoxShadow(
          color: context.colors.shadow.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  static BoxDecoration goldOutlinePanel(BuildContext context) {
    final p = context.qjPalette;
    final r = context.qjRadii;
    return BoxDecoration(
      borderRadius: r.borderMd(),
      gradient: LinearGradient(
        colors: [
          p.goldSubtle.withValues(alpha: 0.15),
          p.emerald.withValues(alpha: 0.06),
        ],
      ),
      border: Border.all(color: p.goldMuted.withValues(alpha: 0.35)),
    );
  }

  static ShapeBorder fabShape(BuildContext context) {
    return RoundedRectangleBorder(borderRadius: context.qjRadii.borderXl());
  }
}

/// Shortcuts for Arabic display styles (use with [Directionality] RTL for ayat).
abstract final class AppStyles {
  static TextStyle arabicVerse(BuildContext context, {double fontSize = 26}) {
    return AppTypography.arabicVerse(
      context.colors.onSurface,
      fontSize: fontSize,
    );
  }

  static TextStyle arabicCaption(BuildContext context, {double fontSize = 18}) {
    return AppTypography.arabicSecondary(
      context.colors.onSurfaceVariant,
      fontSize: fontSize,
    );
  }

  static TextStyle wordmark(BuildContext context) {
    return AppTypography.brandWordmark(context.qjPalette.goldMuted);
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width >= 900 ? AppSpacing.xxxl * 2 : AppSpacing.xl;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: AppSpacing.lg);
  }
}
