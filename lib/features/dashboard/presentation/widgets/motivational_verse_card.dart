import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';

/// Displays a motivational verse card with Arabic text and translation.
class MotivationalVerseCard extends StatelessWidget {
  final MotivationalVerse verse;

  const MotivationalVerseCard({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    final palette = context.qjPalette;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            palette.gold.withValues(alpha: 0.1),
            palette.emerald.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.goldMuted.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded,
                  color: palette.gold, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Verse of the Moment',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: palette.goldMuted,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              verse.arabicText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'Amiri',
                    fontSize: 20,
                    height: 2.0,
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [palette.gold.withValues(alpha: 0.6), palette.emerald.withValues(alpha: 0.6)],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '"${verse.translation}"',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            verse.reference,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: palette.goldMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
          ),
        ],
      ),
    );
  }
}