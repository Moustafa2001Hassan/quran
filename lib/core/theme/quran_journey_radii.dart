import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

@immutable
class QuranJourneyRadii extends ThemeExtension<QuranJourneyRadii> {
  const QuranJourneyRadii({
    this.xs = 6,
    this.sm = 10,
    this.md = 14,
    this.lg = 20,
    this.xl = 28,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  BorderRadius borderXs() => BorderRadius.circular(xs);
  BorderRadius borderSm() => BorderRadius.circular(sm);
  BorderRadius borderMd() => BorderRadius.circular(md);
  BorderRadius borderLg() => BorderRadius.circular(lg);
  BorderRadius borderXl() => BorderRadius.circular(xl);

  static const QuranJourneyRadii standard = QuranJourneyRadii();

  @override
  QuranJourneyRadii copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return QuranJourneyRadii(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  QuranJourneyRadii lerp(ThemeExtension<QuranJourneyRadii>? other, double t) {
    if (other is! QuranJourneyRadii) return this;
    return QuranJourneyRadii(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
    );
  }
}
