import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modern UI typography (Latin labels, navigation) plus readable Arabic styles.
abstract final class AppTypography {
  static const String _uiFallback = 'sans-serif';

  static TextTheme uiTextTheme(ColorScheme scheme) {
    final base = GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    return base.copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: scheme.onSurface,
      ).merge(base.displayLarge),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.35,
        color: scheme.onSurface,
      ).merge(base.displayMedium),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ).merge(base.displaySmall),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ).merge(base.headlineLarge),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ).merge(base.headlineMedium),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ).merge(base.headlineSmall),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ).merge(base.titleLarge),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: scheme.onSurface,
      ).merge(base.titleMedium),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: scheme.onSurface,
      ).merge(base.titleSmall),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w500,
        height: 1.45,
        color: scheme.onSurface,
      ).merge(base.bodyLarge),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: scheme.onSurfaceVariant,
      ).merge(base.bodyMedium),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: scheme.onSurfaceVariant,
      ).merge(base.bodySmall),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: scheme.onSurface,
      ).merge(base.labelLarge),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.35,
        color: scheme.onSurfaceVariant,
      ).merge(base.labelMedium),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: scheme.onSurfaceVariant,
      ).merge(base.labelSmall),
    );
  }

  /// Quranic Arabic — larger line height for diacritics and comfortable reading.
  static TextStyle arabicVerse(Color color, {double fontSize = 26}) {
    return GoogleFonts.amiriQuran(
      fontSize: fontSize,
      height: 2.0,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle arabicSecondary(Color color, {double fontSize = 20}) {
    return GoogleFonts.amiri(
      fontSize: fontSize,
      height: 1.85,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle brandWordmark(Color color) {
    return GoogleFonts.cormorantGaramond(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      color: color,
    );
  }

  static String? get uiFontFamily => GoogleFonts.plusJakartaSans().fontFamily ?? _uiFallback;
}
