import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single memorization session logged by the user.
class MemorizationRecord {
  final String id;
  final String userId;
  final String surahName;
  final int ayahNumber;
  final String ayahText;
  final DateTime createdAt;

  MemorizationRecord({
    required this.id,
    required this.userId,
    required this.surahName,
    required this.ayahNumber,
    required this.ayahText,
    required this.createdAt,
  });

  factory MemorizationRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MemorizationRecord(
      id: doc.id,
      userId: data['userId'] as String,
      surahName: data['surahName'] as String,
      ayahNumber: data['ayahNumber'] as int,
      ayahText: data['ayahText'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'userId': userId,
        'surahName': surahName,
        'ayahNumber': ayahNumber,
        'ayahText': ayahText,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}