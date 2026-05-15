import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_typography.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';
import 'package:quran_journey/core/theme/quran_journey_radii.dart';

/// Premium green & gold Material 3 themes for Quran Journey.
abstract final class AppTheme {
  static ThemeData light() {
    final scheme = _lightColorScheme;
    final palette = QuranJourneyPalette.light();
    final textTheme = AppTypography.uiTextTheme(scheme);
    const radii = QuranJourneyRadii.standard;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      fontFamily: AppTypography.uiFontFamily,
      extensions: <ThemeExtension<dynamic>>[palette, radii],
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: radii.borderLg(),
          side: BorderSide(color: palette.verseBorder.withValues(alpha: 0.35)),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      dividerTheme: DividerThemeData(
        color: palette.goldSubtle.withValues(alpha: 0.55),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.goldSubtle.withValues(alpha: 0.35),
        selectedColor: scheme.primaryContainer,
        disabledColor: scheme.surfaceContainerHighest,
        labelStyle: textTheme.labelMedium!,
        secondaryLabelStyle: textTheme.labelSmall!,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        shape: StadiumBorder(side: BorderSide(color: palette.goldMuted.withValues(alpha: 0.35))),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium!),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: scheme.primary, size: 26);
          }
          return IconThemeData(color: scheme.onSurfaceVariant, size: 24);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
          foregroundColor: scheme.primary,
          side: BorderSide(color: palette.goldMuted.withValues(alpha: 0.65), width: 1.2),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette.gold,
        foregroundColor: scheme.onSecondary,
        elevation: 2,
        highlightElevation: 6,
        shape: RoundedRectangleBorder(borderRadius: radii.borderXl()),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: radii.borderXl()),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radii.xl)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        border: OutlineInputBorder(borderRadius: radii.borderMd(), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: radii.borderMd(),
          borderSide: BorderSide(color: palette.verseBorder.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radii.borderMd(),
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        hintStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 24),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
      ),
    );
  }

  static ThemeData dark() {
    final scheme = _darkColorScheme;
    final palette = QuranJourneyPalette.dark();
    final textTheme = AppTypography.uiTextTheme(scheme);
    const radii = QuranJourneyRadii.standard;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      fontFamily: AppTypography.uiFontFamily,
      extensions: <ThemeExtension<dynamic>>[palette, radii],
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: radii.borderLg(),
          side: BorderSide(color: palette.verseBorder.withValues(alpha: 0.55)),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),
      dividerTheme: DividerThemeData(
        color: palette.goldSubtle.withValues(alpha: 0.45),
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.goldSubtle.withValues(alpha: 0.45),
        selectedColor: scheme.primaryContainer,
        disabledColor: scheme.surfaceContainerHighest,
        labelStyle: textTheme.labelMedium!,
        secondaryLabelStyle: textTheme.labelSmall!,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        shape: StadiumBorder(side: BorderSide(color: palette.goldMuted.withValues(alpha: 0.55))),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium!),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: scheme.primary, size: 26);
          }
          return IconThemeData(color: scheme.onSurfaceVariant, size: 24);
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          minimumSize: const Size(48, 52),
          shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
          foregroundColor: palette.gold,
          side: BorderSide(color: palette.goldMuted.withValues(alpha: 0.85), width: 1.2),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.gold,
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette.gold,
        foregroundColor: scheme.onSecondary,
        elevation: 2,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: radii.borderXl()),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: radii.borderMd()),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: radii.borderXl()),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radii.xl)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        border: OutlineInputBorder(borderRadius: radii.borderMd(), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: radii.borderMd(),
          borderSide: BorderSide(color: palette.verseBorder.withValues(alpha: 0.45)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radii.borderMd(),
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        hintStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 24),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
      ),
    );
  }

  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF0B6E4F),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFFB8EBD9),
    onPrimaryContainer: const Color(0xFF002118),
    secondary: const Color(0xFFC9A227),
    onSecondary: const Color(0xFF211A00),
    secondaryContainer: const Color(0xFFF6ECC8),
    onSecondaryContainer: const Color(0xFF231A00),
    tertiary: const Color(0xFF4B6B60),
    onTertiary: const Color(0xFFFFFFFF),
    tertiaryContainer: const Color(0xFFCFE8DE),
    onTertiaryContainer: const Color(0xFF072019),
    error: const Color(0xFFBA1A1A),
    onError: const Color(0xFFFFFFFF),
    errorContainer: const Color(0xFFFFDAD6),
    onErrorContainer: const Color(0xFF410002),
    surface: const Color(0xFFFAF8F3),
    onSurface: const Color(0xFF1B1B18),
    surfaceContainerLow: const Color(0xFFF3EFE6),
    surfaceContainer: const Color(0xFFEDE8DD),
    surfaceContainerHigh: const Color(0xFFE6E0D4),
    surfaceContainerHighest: const Color(0xFFDED7C9),
    onSurfaceVariant: const Color(0xFF4D4940),
    outline: const Color(0xFF8C8578),
    outlineVariant: const Color(0xFFCFC6B6),
    shadow: const Color(0xFF000000),
    scrim: const Color(0xFF000000),
    inverseSurface: const Color(0xFF2F2E2A),
    onInverseSurface: const Color(0xFFF5F1E8),
    inversePrimary: const Color(0xFF8FE0C3),
    surfaceTint: const Color(0xFF0B6E4F),
  );

  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: const Color(0xFF4CD4A8),
    onPrimary: const Color(0xFF003328),
    primaryContainer: const Color(0xFF12342C),
    onPrimaryContainer: const Color(0xFFB8EBD9),
    secondary: const Color(0xFFE6C45C),
    onSecondary: const Color(0xFF221800),
    secondaryContainer: const Color(0xFF3A3218),
    onSecondaryContainer: const Color(0xFFFFEEBB),
    tertiary: const Color(0xFF9ECFC0),
    onTertiary: const Color(0xFF072019),
    tertiaryContainer: const Color(0xFF1E3C33),
    onTertiaryContainer: const Color(0xFFCFE8DE),
    error: const Color(0xFFFFB4AB),
    onError: const Color(0xFF690005),
    errorContainer: const Color(0xFF93000A),
    onErrorContainer: const Color(0xFFFFDAD6),
    surface: const Color(0xFF0C1210),
    onSurface: const Color(0xFFE6E2DA),
    surfaceContainerLow: const Color(0xFF141C19),
    surfaceContainer: const Color(0xFF1A231F),
    surfaceContainerHigh: const Color(0xFF202824),
    surfaceContainerHighest: const Color(0xFF2A332F),
    onSurfaceVariant: const Color(0xFFC8C2B8),
    outline: const Color(0xFF989286),
    outlineVariant: const Color(0xFF4A524E),
    shadow: const Color(0xFF000000),
    scrim: const Color(0xFF000000),
    inverseSurface: const Color(0xFFE6E2DA),
    onInverseSurface: const Color(0xFF2F2E2A),
    inversePrimary: const Color(0xFF0B6E4F),
    surfaceTint: const Color(0xFF4CD4A8),
  );
}
