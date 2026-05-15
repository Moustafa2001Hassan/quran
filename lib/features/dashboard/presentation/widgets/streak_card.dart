import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';
import 'package:quran_journey/core/theme/build_context_extension.dart';

/// Streak card with animated flame icon — defined here to keep imports clean.
/// This is also defined in progress_chart.dart but exported from dashboard barrel.
class StreakCard extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.qjPalette;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            palette.emerald.withValues(alpha: 0.15),
            palette.goldSubtle.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.emerald.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          _buildStreakIcon(palette),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      '$currentStreak',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: palette.emerald,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'days',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildStreakBar(palette),
                const SizedBox(height: 6),
                Text(
                  'Best: $longestStreak days',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: palette.goldMuted,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakIcon(QuranJourneyPalette palette) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: palette.emerald.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: currentStreak >= 7
            ? Icon(
                Icons.local_fire_department_rounded,
                color: palette.gold,
                size: 28,
              )
            : Icon(
                Icons.whatshot_rounded,
                color: palette.emerald,
                size: 28,
              ),
      ),
    );
  }

  Widget _buildStreakBar(QuranJourneyPalette palette) {
    final progress = (currentStreak / max(longestStreak, 1)).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: currentStreak > 0 ? progress : 0,
        minHeight: 4,
        backgroundColor: Colors.grey.withValues(alpha: 0.15),
        valueColor: AlwaysStoppedAnimation<Color>(
          currentStreak >= 7 ? const Color(0xFFFF6B35) : const Color(0xFF0B6E4F),
        ),
      ),
    );
  }
}