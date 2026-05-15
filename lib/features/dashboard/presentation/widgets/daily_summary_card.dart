import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';

/// Summary card showing today's memorization count.
class DailySummaryCard extends StatelessWidget {
  final int memorizedCount;
  final int revisedCount;
  final int totalMemorized;
  final int totalRevised;

  const DailySummaryCard({
    super.key,
    required this.memorizedCount,
    required this.revisedCount,
    required this.totalMemorized,
    required this.totalRevised,
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
            palette.verseSurface,
            palette.emerald.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.verseBorder.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStatItem(
            context,
            icon: Icons.menu_book_rounded,
            count: memorizedCount,
            label: 'Memorized Today',
            color: palette.emerald,
          ),
          _buildDivider(context),
          _buildStatItem(
            context,
            icon: Icons.refresh_rounded,
            count: revisedCount,
            label: 'Revised Today',
            color: palette.gold,
          ),
          _buildDivider(context),
          _buildStatItem(
            context,
            icon: Icons.library_books_rounded,
            count: totalMemorized + totalRevised,
            label: 'Total Progress',
            color: scheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required int count,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.3),
    );
  }
}