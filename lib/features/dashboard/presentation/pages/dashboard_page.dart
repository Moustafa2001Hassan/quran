import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/daily_summary_card.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/motivational_verse_card.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/progress_chart.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/revision_task_list.dart';
import 'package:quran_journey/features/dashboard/presentation/widgets/streak_card.dart';


/// Main Dashboard page — shown after authentication.
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final palette = context.qjPalette;

    // Watch providers
    final todayMemorizations = ref.watch(todayMemorizationsProvider);
    final userProgressAsync = ref.watch(userProgressProvider);
    final revisionsAsync = ref.watch(pendingRevisionsProvider);
    final verseAsync = ref.watch(motivationalVerseProvider);
    final progressHistoryAsync = ref.watch(progressHistoryProvider);

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.auto_stories_rounded,
                color: palette.gold, size: 28),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Quran Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            tooltip: 'Sign out',
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshAll(ref),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width >= 900
                ? AppSpacing.xxxl * 2
                : AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              _buildGreeting(context),
              const SizedBox(height: AppSpacing.xl),

              // Motivational Verse
              verseAsync.when(
                data: (verse) {
                  if (verse == null) return const SizedBox.shrink();
                  return MotivationalVerseCard(verse: verse)
                      .animate()
                      .fadeIn(duration: 600.ms);
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Daily Summary
              todayMemorizations.when(
                data: (records) {
                  return DailySummaryCard(
                    memorizedCount: records.length,
                    revisedCount: 0, // TODO: integrate revision count
                    totalMemorized: userProgressAsync.value?.totalMemorized ?? 0,
                    totalRevised: userProgressAsync.value?.totalRevised ?? 0,
                  )
                      .animate()
                      .fadeIn(duration: 500.ms);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Streak Card
              userProgressAsync.when(
                data: (progress) {
                  if (progress == null) return const SizedBox.shrink();
                  return StreakCard(
                    currentStreak: progress.currentStreak,
                    longestStreak: progress.longestStreak,
                  ).animate().fadeIn(duration: 600.ms);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Progress Chart
              progressHistoryAsync.when(
                data: (history) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Weekly Progress',
                        onSeeAll: null,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ProgressChart(dailyProgress: history)
                          .animate()
                          .fadeIn(duration: 700.ms),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Today's Memorization Section
              todayMemorizations.when(
                data: (records) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Today\'s Memorization',
                        onSeeAll: null,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TodayMemorizationList(records: records),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Revision Tasks Section
              revisionsAsync.when(
                data: (tasks) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Upcoming Revisions',
                        onSeeAll: null,
                      ),
                      const SizedBox(height: AppSpacing.md),
                       RevisionTaskList(
                         tasks: tasks,
                         onTaskCompleted: (task) =>
                             _completeRevision(context, ref, task.id),
                         onTaskDeleted: (task) =>
                             _deleteRevision(context, ref, task.id),
                       ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting,',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          'Here\'s your memorization progress.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  Future<void> _refreshAll(WidgetRef ref) async {
    ref.invalidate(todayMemorizationsProvider);
    ref.invalidate(userProgressProvider);
    ref.invalidate(pendingRevisionsProvider);
    ref.invalidate(motivationalVerseProvider);
    ref.invalidate(progressHistoryProvider);
  }

   Future<void> _completeRevision(BuildContext context, WidgetRef ref, String taskId) async {
     try {
       await ref.read(dashboardRepositoryProvider).completeRevisionTask(taskId);
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Revision task completed! 🎉')),
         );
       }
       ref.invalidate(pendingRevisionsProvider);
     } catch (e) {
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: $e')),
         );
       }
     }
   }
 
   Future<void> _deleteRevision(BuildContext context, WidgetRef ref, String taskId) async {
     try {
       await ref.read(dashboardRepositoryProvider).deleteRevisionTask(taskId);
       ref.invalidate(pendingRevisionsProvider);
     } catch (e) {
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: $e')),
         );
       }
     }
   }
}
