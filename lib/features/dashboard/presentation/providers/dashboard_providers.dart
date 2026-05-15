import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:quran_journey/features/dashboard/data/datasources/dashboard_remote_data_source_impl.dart';
import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';
import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/data/models/user_progress.dart';
import 'package:quran_journey/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:quran_journey/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Firestore instance provider - ensures Firebase is initialized before access.
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// Remote data source provider.
final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>(
  (ref) => DashboardRemoteDataSourceImpl(ref.watch(firestoreProvider)),
);

/// Repository provider.
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(ref.watch(dashboardRemoteDataSourceProvider));
});

/// Future provider for today's memorization records.
final todayMemorizationsProvider =
    FutureProvider.autoDispose<List<MemorizationRecord>>((ref) async {
      final userId = ref.watch(authStateChangesProvider).value?.uid;
      if (userId == null) return [];
      return ref
          .watch(dashboardRepositoryProvider)
          .getTodayMemorizations(userId);
    });

/// Async provider for user progress.
final userProgressProvider = FutureProvider.autoDispose<UserProgress?>((
  ref,
) async {
  final userId = ref.watch(authStateChangesProvider).value?.uid;
  if (userId == null) return null;
  return ref.watch(dashboardRepositoryProvider).getUserProgress(userId);
});

/// Async provider for pending revision tasks.
final pendingRevisionsProvider = FutureProvider.autoDispose<List<RevisionTask>>(
  (ref) async {
    final userId = ref.watch(authStateChangesProvider).value?.uid;
    if (userId == null) return [];
    return ref.watch(dashboardRepositoryProvider).getPendingRevisions(userId);
  },
);

/// Async provider for a random motivational verse.
final motivationalVerseProvider =
    FutureProvider.autoDispose<MotivationalVerse?>((ref) async {
      return ref
          .watch(dashboardRepositoryProvider)
          .getRandomMotivationalVerse();
    });

/// Async provider for progress history (last 30 days).
final progressHistoryProvider = FutureProvider.autoDispose<List<DailyProgress>>(
  (ref) async {
    final userId = ref.watch(authStateChangesProvider).value?.uid;
    if (userId == null) return [];
    return ref
        .watch(dashboardRepositoryProvider)
        .getProgressHistory(userId, 30);
  },
);
