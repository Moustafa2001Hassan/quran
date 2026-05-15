import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';
import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/data/models/user_progress.dart';

abstract class DashboardRepository {
  Future<UserProgress> getUserProgress(String userId);
  Future<void> updateUserProgress(UserProgress progress);
  Future<void> logMemorization(MemorizationRecord record);
  Future<List<MemorizationRecord>> getTodayMemorizations(String userId);
  Future<List<DailyProgress>> getProgressHistory(String userId, int days);
  Future<List<RevisionTask>> getPendingRevisions(String userId);
  Future<void> completeRevisionTask(String taskId);
  Future<void> deleteRevisionTask(String taskId);
  Future<void> addRevisionTask(RevisionTask task);
  Future<MotivationalVerse> getRandomMotivationalVerse();
  Future<List<DailyProgress>> getDailyProgressInRange(
      String userId, DateTime start, DateTime end);

  /// Pure function: calculate streak from history.
  int calculateCurrentStreak(List<DailyProgress> progressHistory);
  int calculateLongestStreak(List<DailyProgress> progressHistory);
}