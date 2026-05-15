import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/core/theme/quran_journey_palette.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';

/// A card displaying a single revision task.
class RevisionTaskCard extends StatelessWidget {
  final RevisionTask task;
  final VoidCallback? onComplete;
  final VoidCallback? onDelete;

  const RevisionTaskCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = context.qjPalette;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.goldMuted.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.surahName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ayahs ${task.fromAyah} – ${task.toAyah}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 4),
                    _buildScheduledTime(context, scheme, palette),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onComplete != null)
                    IconButton(
                      onPressed: onComplete,
                      icon: Icon(Icons.check_circle_outline_rounded,
                          color: palette.emerald),
                      tooltip: 'Mark as complete',
                    ),
                  if (onDelete != null)
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: Colors.redAccent),
                      tooltip: 'Delete task',
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledTime(
      BuildContext context, ColorScheme scheme, QuranJourneyPalette palette) {
    final difference = task.scheduledFor.difference(DateTime.now());
    final isPast = difference.isNegative;

    String timeLabel;
    if (isPast) {
      timeLabel = 'Overdue';
    } else if (difference.inHours < 1) {
      timeLabel = 'Due in ${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      timeLabel = 'Due in ${difference.inHours}h';
    } else {
      timeLabel = 'Due in ${difference.inDays}d';
    }

    return Row(
      children: [
        Icon(
          isPast ? Icons.warning_rounded : Icons.schedule_outlined,
          size: 14,
          color: isPast ? Colors.redAccent : scheme.primary,
        ),
        const SizedBox(width: 4),
        Text(
          timeLabel,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isPast ? Colors.redAccent : scheme.onSurfaceVariant,
                fontWeight: isPast ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
        if (task.completed) ...[
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.check_circle_rounded, size: 14, color: Colors.green),
        ],
      ],
    );
  }
}