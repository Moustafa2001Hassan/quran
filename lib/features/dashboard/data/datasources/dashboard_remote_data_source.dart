import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/data/models/user_progress.dart';
import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';

abstract class DashboardRemoteDataSource {
  /// Fetch the current user's progress from Firestore.
  Future<UserProgress> getUserProgress(String userId);

  /// Update the user's progress in Firestore.
  Future<void> updateUserProgress(UserProgress progress);

  /// Log a new memorization record.
  Future<void> addMemorizationRecord(MemorizationRecord record);

  /// Get today's memorization records for a user.
  Future<List<MemorizationRecord>> getTodayMemorizations(String userId);

  /// Get memorization records for the last N days for charting.
  Future<List<DailyProgress>> getProgressHistory(String userId, int days);

  /// Fetch upcoming/pending revision tasks.
  Future<List<RevisionTask>> getPendingRevisions(String userId);

  /// Mark a revision task as completed.
  Future<void> completeRevisionTask(String taskId);

  /// Delete a revision task.
  Future<void> deleteRevisionTask(String taskId);

  /// Add a new revision task.
  Future<void> addRevisionTask(RevisionTask task);

  /// Fetch a random motivational verse.
  Future<MotivationalVerse> getRandomMotivationalVerse();

  /// Fetch daily progress for a specific date range.
  Future<List<DailyProgress>> getDailyProgressInRange(
    String userId,
    DateTime start,
    DateTime end,
  );
}
