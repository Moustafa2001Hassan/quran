import 'package:flutter/material.dart';

/// Semantic greens and golds beyond [ColorScheme] — verse surfaces, ornaments, etc.
@immutable
class QuranJourneyPalette extends ThemeExtension<QuranJourneyPalette> {
  const QuranJourneyPalette({
    required this.gold,
    required this.goldMuted,
    required this.goldSubtle,
    required this.emerald,
    required this.emeraldMuted,
    required this.verseSurface,
    required this.verseBorder,
    required this.ornament,
    required this.audioAccent,
    required this.success,
    required this.warning,
  });

  final Color gold;
  final Color goldMuted;
  final Color goldSubtle;
  final Color emerald;
  final Color emeraldMuted;
  final Color verseSurface;
  final Color verseBorder;
  final Color ornament;
  final Color audioAccent;
  final Color success;
  final Color warning;

  static QuranJourneyPalette light() {
    return const QuranJourneyPalette(
      gold: Color(0xFFC9A227),
      goldMuted: Color(0xFF9A7B1C),
      goldSubtle: Color(0xFFE6D7A2),
      emerald: Color(0xFF0B6E4F),
      emeraldMuted: Color(0xFF0F5A43),
      verseSurface: Color(0xFFF3EFE4),
      verseBorder: Color(0xFFD9C896),
      ornament: Color(0xFF1A5C47),
      audioAccent: Color(0xFFB8860B),
      success: Color(0xFF1F8A65),
      warning: Color(0xFFC27F1A),
    );
  }

  static QuranJourneyPalette dark() {
    return const QuranJourneyPalette(
      gold: Color(0xFFE6C45C),
      goldMuted: Color(0xFFC9A94A),
      goldSubtle: Color(0xFF4A4020),
      emerald: Color(0xFF2EB88C),
      emeraldMuted: Color(0xFF217A5F),
      verseSurface: Color(0xFF121A17),
      verseBorder: Color(0xFF3A3420),
      ornament: Color(0xFF8FD4B8),
      audioAccent: Color(0xFFFFD76A),
      success: Color(0xFF3DDC9A),
      warning: Color(0xFFE6A23A),
    );
  }

  @override
  QuranJourneyPalette copyWith({
    Color? gold,
    Color? goldMuted,
    Color? goldSubtle,
    Color? emerald,
    Color? emeraldMuted,
    Color? verseSurface,
    Color? verseBorder,
    Color? ornament,
    Color? audioAccent,
    Color? success,
    Color? warning,
  }) {
    return QuranJourneyPalette(
      gold: gold ?? this.gold,
      goldMuted: goldMuted ?? this.goldMuted,
      goldSubtle: goldSubtle ?? this.goldSubtle,
      emerald: emerald ?? this.emerald,
      emeraldMuted: emeraldMuted ?? this.emeraldMuted,
      verseSurface: verseSurface ?? this.verseSurface,
      verseBorder: verseBorder ?? this.verseBorder,
      ornament: ornament ?? this.ornament,
      audioAccent: audioAccent ?? this.audioAccent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  QuranJourneyPalette lerp(ThemeExtension<QuranJourneyPalette>? other, double t) {
    if (other is! QuranJourneyPalette) return this;
    return QuranJourneyPalette(
      gold: Color.lerp(gold, other.gold, t)!,
      goldMuted: Color.lerp(goldMuted, other.goldMuted, t)!,
      goldSubtle: Color.lerp(goldSubtle, other.goldSubtle, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
      emeraldMuted: Color.lerp(emeraldMuted, other.emeraldMuted, t)!,
      verseSurface: Color.lerp(verseSurface, other.verseSurface, t)!,
      verseBorder: Color.lerp(verseBorder, other.verseBorder, t)!,
      ornament: Color.lerp(ornament, other.ornament, t)!,
      audioAccent: Color.lerp(audioAccent, other.audioAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}
