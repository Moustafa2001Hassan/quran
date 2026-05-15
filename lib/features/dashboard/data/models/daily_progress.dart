import 'package:cloud_firestore/cloud_firestore.dart';

/// Daily progress summary for charting.
class DailyProgress {
  final DateTime date;
  final int memorizedCount;
  final int revisedCount;

  DailyProgress({
    required this.date,
    required this.memorizedCount,
    required this.revisedCount,
  });

  factory DailyProgress.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DailyProgress(
      date: (data['date'] as Timestamp).toDate(),
      memorizedCount: data['memorizedCount'] as int? ?? 0,
      revisedCount: data['revisedCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'date': Timestamp.fromDate(date),
    'memorizedCount': memorizedCount,
    'revisedCount': revisedCount,
  };
}
