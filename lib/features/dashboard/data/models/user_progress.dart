import 'package:cloud_firestore/cloud_firestore.dart';

/// Tracks the user's memorization streaks and overall progress.
class UserProgress {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final int totalMemorized;
  final int totalRevised;
  final DateTime lastActivityDate;
  final Map<String, dynamic>? metadata;

  UserProgress({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalMemorized,
    required this.totalRevised,
    required this.lastActivityDate,
    this.metadata,
  });

  factory UserProgress.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProgress(
      userId: doc.id,
      currentStreak: data['currentStreak'] as int? ?? 0,
      longestStreak: data['longestStreak'] as int? ?? 0,
      totalMemorized: data['totalMemorized'] as int? ?? 0,
      totalRevised: data['totalRevised'] as int? ?? 0,
      lastActivityDate:
          (data['lastActivityDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'currentStreak': currentStreak,
        'longestStreak': longestStreak,
        'totalMemorized': totalMemorized,
        'totalRevised': totalRevised,
        'lastActivityDate': Timestamp.fromDate(lastActivityDate),
        'metadata': metadata,
      };

  UserProgress copyWith({
    int? currentStreak,
    int? longestStreak,
    int? totalMemorized,
    int? totalRevised,
    DateTime? lastActivityDate,
    Map<String, dynamic>? metadata,
  }) {
    return UserProgress(
      userId: userId,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalMemorized: totalMemorized ?? this.totalMemorized,
      totalRevised: totalRevised ?? this.totalRevised,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      metadata: metadata ?? this.metadata,
    );
  }
}