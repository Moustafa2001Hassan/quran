import 'dart:math';

import 'package:quran_journey/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';
import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/data/models/user_progress.dart';
import 'package:quran_journey/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserProgress> getUserProgress(String userId) =>
      _remoteDataSource.getUserProgress(userId);

  @override
  Future<void> updateUserProgress(UserProgress progress) =>
      _remoteDataSource.updateUserProgress(progress);

  @override
  Future<void> logMemorization(MemorizationRecord record) =>
      _remoteDataSource.addMemorizationRecord(record);

  @override
  Future<List<MemorizationRecord>> getTodayMemorizations(String userId) =>
      _remoteDataSource.getTodayMemorizations(userId);

  @override
  Future<List<DailyProgress>> getProgressHistory(String userId, int days) =>
      _remoteDataSource.getProgressHistory(userId, days);

  @override
  Future<List<RevisionTask>> getPendingRevisions(String userId) =>
      _remoteDataSource.getPendingRevisions(userId);

  @override
  Future<void> completeRevisionTask(String taskId) =>
      _remoteDataSource.completeRevisionTask(taskId);

  @override
  Future<void> deleteRevisionTask(String taskId) =>
      _remoteDataSource.deleteRevisionTask(taskId);

  @override
  Future<void> addRevisionTask(RevisionTask task) =>
      _remoteDataSource.addRevisionTask(task);

  @override
  Future<MotivationalVerse> getRandomMotivationalVerse() =>
      _remoteDataSource.getRandomMotivationalVerse();

  @override
  Future<List<DailyProgress>> getDailyProgressInRange(
          String userId, DateTime start, DateTime end) =>
      _remoteDataSource.getDailyProgressInRange(userId, start, end);

  @override
  int calculateCurrentStreak(List<DailyProgress> progressHistory) {
    if (progressHistory.isEmpty) return 0;

    final sorted = progressHistory.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    int streak = 0;
    DateTime currentCheck = DateTime.now();

    // Start from today
    for (final entry in sorted) {
      final entryDate = DateTime(
          entry.date.year, entry.date.month, entry.date.day);
      final checkDate = DateTime(
          currentCheck.year, currentCheck.month, currentCheck.day);

      if (entryDate.isAtSameMomentAs(checkDate)) {
        streak++;
        currentCheck = currentCheck.subtract(const Duration(days: 1));
      } else if (entryDate.isBefore(checkDate)) {
        break;
      }
    }

    // Also check if today has any entries
    final today = DateTime.now();
    final hasTodayEntry = sorted.any((e) =>
        e.date.year == today.year &&
        e.date.month == today.month &&
        e.date.day == today.day);

    if (!hasTodayEntry) {
      // Check yesterday
      final yesterday = today.subtract(const Duration(days: 1));
      final hasYesterdayEntry = sorted.any((e) =>
          e.date.year == yesterday.year &&
          e.date.month == yesterday.month &&
          e.date.day == yesterday.day);
      if (!hasYesterdayEntry) return 0;
    }

    return streak;
  }

  @override
  int calculateLongestStreak(List<DailyProgress> progressHistory) {
    if (progressHistory.isEmpty) return 0;

    // Get all unique dates that had activity
    final activeDates = progressHistory
        .where((e) => e.memorizedCount > 0 || e.revisedCount > 0)
        .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
        .toSet();

    if (activeDates.isEmpty) return 0;

    final sortedDates = activeDates.toList()
      ..sort();

    int longestStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < sortedDates.length; i++) {
      final prev = sortedDates[i - 1];
      final curr = sortedDates[i];
      final diff = curr.difference(prev).inDays;

      if (diff == 1) {
        currentStreak++;
        longestStreak = max(longestStreak, currentStreak);
      } else {
        currentStreak = 1;
      }
    }

    return longestStreak;
  }
}