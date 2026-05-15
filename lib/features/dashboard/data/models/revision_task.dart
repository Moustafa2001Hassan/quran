import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a revision task scheduled for the user.
class RevisionTask {
  final String id;
  final String userId;
  final String surahName;
  final int fromAyah;
  final int toAyah;
  final DateTime scheduledFor;
  final bool completed;
  final DateTime createdAt;

  RevisionTask({
    required this.id,
    required this.userId,
    required this.surahName,
    required this.fromAyah,
    required this.toAyah,
    required this.scheduledFor,
    required this.completed,
    required this.createdAt,
  });

  factory RevisionTask.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RevisionTask(
      id: doc.id,
      userId: data['userId'] as String,
      surahName: data['surahName'] as String,
      fromAyah: data['fromAyah'] as int,
      toAyah: data['toAyah'] as int,
      scheduledFor: (data['scheduledFor'] as Timestamp).toDate(),
      completed: data['completed'] as bool,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'surahName': surahName,
        'fromAyah': fromAyah,
        'toAyah': toAyah,
        'scheduledFor': Timestamp.fromDate(scheduledFor),
        'completed': completed,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}