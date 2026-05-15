import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';

@immutable
class OnboardingSlideData {
  const OnboardingSlideData({
    required this.title,
    required this.subtitle,
    required this.arabic,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String arabic;
  final IconData icon;

  static const List<OnboardingSlideData> slides = [
    OnboardingSlideData(
      title: 'Quran Journey',
      subtitle:
          'A calm space to memorize, revise, and grow closer to the Book of Allah — one ayah at a time.',
      arabic: 'اقْرَأْ بِاسْمِ رَبِّكَ',
      icon: Icons.menu_book_rounded,
    ),
    OnboardingSlideData(
      title: 'Listen & repeat',
      subtitle:
          'Follow along with clear recitation, loop verses, and keep your ears and heart in sync.',
      arabic: 'وَرَتِّلِ الْقُرْآنَ تَرْتِيلًا',
      icon: Icons.graphic_eq_rounded,
    ),
    OnboardingSlideData(
      title: 'Track your path',
      subtitle:
          'Gentle charts and streaks celebrate consistency — without turning worship into a race.',
      arabic: 'وَالضُّحَىٰ',
      icon: Icons.auto_graph_rounded,
    ),
    OnboardingSlideData(
      title: 'Begin with barakah',
      subtitle:
          'Take a breath, make a sincere intention, and open the mushaf when you are ready.',
      arabic: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
      icon: Icons.favorite_rounded,
    ),
  ];

  static int get count => slides.length;

  static EdgeInsets contentPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    final horizontal = w >= 720 ? AppSpacing.xxxl * 2.5 : AppSpacing.xl + AppSpacing.md;
    final top = math.max(h * 0.08, AppSpacing.xxxl);
    return EdgeInsets.fromLTRB(horizontal, top, horizontal, AppSpacing.xl);
  }
}
