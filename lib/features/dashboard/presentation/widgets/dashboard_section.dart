import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/memorization_card.dart';

/// Section header with "See All" link.
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'See all',
              style: TextStyle(color: scheme.primary),
            ),
          ),
      ],
    );
  }
}

/// Scrollable list of memorization cards for today.
class TodayMemorizationList extends StatelessWidget {
  final List<MemorizationRecord> records;

  const TodayMemorizationList({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.menu_book_outlined,
                  size: 48,
                  color:
                      Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No memorization yet today',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Start your memorization journey!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: records.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final record = records[index];
        return MemorizationCard(
          surahName: record.surahName,
          ayahNumber: record.ayahNumber,
          ayahText: record.ayahText,
          createdAt: record.createdAt,
        ).animate().fadeIn(delay: Duration(milliseconds: 50 * index));
      },
    );
  }
}
