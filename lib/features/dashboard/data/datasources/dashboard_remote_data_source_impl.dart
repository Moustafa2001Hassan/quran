import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quran_journey/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:quran_journey/features/dashboard/data/models/daily_progress.dart';
import 'package:quran_journey/features/dashboard/data/models/memorization_record.dart';
import 'package:quran_journey/features/dashboard/data/models/motivational_verse.dart';
import 'package:quran_journey/features/dashboard/data/models/revision_task.dart';
import 'package:quran_journey/features/dashboard/data/models/user_progress.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore _firestore;

  DashboardRemoteDataSourceImpl(this._firestore);

  @override
  Future<UserProgress> getUserProgress(String userId) async {
    final doc =
        await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserProgress.fromFirestore(doc);
    }
    // Return default progress for new users
    return UserProgress(
      userId: userId,
      currentStreak: 0,
      longestStreak: 0,
      totalMemorized: 0,
      totalRevised: 0,
      lastActivityDate: DateTime.now(),
    );
  }

  @override
  Future<void> updateUserProgress(UserProgress progress) async {
    await _firestore
        .collection('users')
        .doc(progress.userId)
        .set(progress.toFirestore());
  }

  @override
  Future<void> addMemorizationRecord(MemorizationRecord record) async {
    await _firestore
        .collection('memorization_records')
        .doc(record.id)
        .set(record.toFirestore());
  }

  @override
  Future<List<MemorizationRecord>> getTodayMemorizations(String userId) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _firestore
        .collection('memorization_records')
        .where('userId', isEqualTo: userId)
        .where('createdAt', isGreaterThanOrEqualTo: startOfDay)
        .where('createdAt', isLessThan: endOfDay)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => MemorizationRecord.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<DailyProgress>> getProgressHistory(
      String userId, int days) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(Duration(days: days));

    final snapshot = await _firestore
        .collection('daily_progress')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DailyProgress.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<RevisionTask>> getPendingRevisions(String userId) async {
    final snapshot = await _firestore
        .collection('revision_tasks')
        .where('userId', isEqualTo: userId)
        .where('completed', isEqualTo: false)
        .where('scheduledFor',
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .orderBy('scheduledFor', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => RevisionTask.fromFirestore(doc))
        .toList();
  }

  @override
  Future<void> completeRevisionTask(String taskId) async {
    await _firestore.collection('revision_tasks').doc(taskId).update({
      'completed': true,
    });
  }

  @override
  Future<void> deleteRevisionTask(String taskId) async {
    await _firestore.collection('revision_tasks').doc(taskId).delete();
  }

  @override
  Future<void> addRevisionTask(RevisionTask task) async {
    await _firestore
        .collection('revision_tasks')
        .doc(task.id)
        .set(task.toFirestore());
  }

  @override
  Future<MotivationalVerse> getRandomMotivationalVerse() async {
    // Local curated verses as fallback / default
    final defaultVerses = _defaultVerses();
    try {
      final snapshot = await _firestore
          .collection('motivational_verses')
          .get();

      if (snapshot.docs.isNotEmpty) {
        final randomIndex =
            DateTime.now().millisecondsSinceEpoch % snapshot.docs.length;
        return _verseFromDoc(snapshot.docs[randomIndex]);
      }
    } catch (_) {
      // Fallback to local verses
    }
    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % defaultVerses.length;
    return defaultVerses[randomIndex];
  }

  List<MotivationalVerse> _defaultVerses() => [
        MotivationalVerse(
          id: 'v1',
          arabicText: 'وَاعْلَمُوا أَنَّمَا جَاءَكُمُ الرَّسُولُ بِنُورٍ مِّنَ اللَّهِ',
          translation:
              'And know that the Messenger has brought you the light from Allah.',
          reference: 'Surah Al-Ma\'idah 5:15',
          tags: ['guidance', 'light'],
        ),
        MotivationalVerse(
          id: 'v2',
          arabicText: 'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
          translation: 'Indeed, with hardship [will be] ease.',
          reference: 'Surah Ash-Sharh 94:6',
          tags: ['patience', 'ease'],
        ),
        MotivationalVerse(
          id: 'v3',
          arabicText: 'وَمَن يَقْنُطْ مِن رَّحْمَةِ رَبِّهِ إِلَّا الضَّالُّونَ',
          translation:
              'And who despairs of the mercy of his Lord except for those astray?',
          reference: 'Surah Al-Hijr 15:56',
          tags: ['hope', 'mercy'],
        ),
        MotivationalVerse(
          id: 'v4',
          arabicText: 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا * إِنَّ مَعَ الْعُسْرِ يُسْرًا',
          translation:
              'For indeed, with hardship [will be] ease. Indeed, with hardship [will be] ease.',
          reference: 'Surah Ash-Sharh 94:5-6',
          tags: ['patience', 'ease', 'comfort'],
        ),
        MotivationalVerse(
          id: 'v5',
          arabicText:
              'يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا قُمْتُمْ إِلَى الصَّلَاةِ فَاغْسِلُوا وُجُوهَكُمْ وَأَيْدِيَكُمْ إِلَى الْمَرَافِقِ',
          translation:
              'O you who believe, when you rise to prayer, wash your faces and your hands to the elbows.',
          reference: 'Surah Al-Ma\'idah 5:6',
          tags: ['purification', 'prayer'],
        ),
        MotivationalVerse(
          id: 'v6',
          arabicText: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً',
          translation:
              'Our Lord, give us in this world [that which is] good and in the Hereafter [that which is] good.',
          reference: 'Surah Al-Baqarah 2:201',
          tags: ['dua', 'goodness'],
        ),
        MotivationalVerse(
          id: 'v7',
          arabicText:
              'وَمَن يُوقَ شُحَّ نَفْسِهِ فَأُولَٰئِكَ هُمُ الْمُفْلِحُونَ',
          translation:
              'And whoever is protected from the stinginess of his soul — it is those who will be the successful.',
          reference: 'Surah Al-Hashr 59:9',
          tags: ['generosity', 'success'],
        ),
        MotivationalVerse(
          id: 'v8',
          arabicText: 'وَقُل رَّبِّ زِدْنِي عِلْمًا',
          translation: 'And say, "My Lord, increase me in knowledge."',
          reference: 'Surah Taha 20:114',
          tags: ['knowledge', 'growth'],
        ),
        MotivationalVerse(
          id: 'v9',
          arabicText:
              'إِنَّ اللَّهَ لَا يُغَفِّرُ أَن يُشْرَكَ بِهِ وَيَغْفِرُ مَا دُونَ ذَٰلِكَ لِمَن يَشَاءُ',
          translation:
              'Indeed, Allah does not forgive association with Him, but He forgives what is less than that for whom He wills.',
          reference: 'Surah An-Nisa 4:48',
          tags: ['forgiveness', 'tawheed'],
        ),
        MotivationalVerse(
          id: 'v10',
          arabicText: 'وَصَلِّ لِرَبِّكَ وَانْحَرْ',
          translation: 'And pray to your Lord and sacrifice.',
          reference: 'Surah Al-Kawthar 108:2',
          tags: ['prayer', 'sacrifice'],
        ),
      ];

  MotivationalVerse _verseFromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MotivationalVerse(
      id: doc.id,
      arabicText: data['arabicText'] as String,
      translation: data['translation'] as String,
      reference: data['reference'] as String,
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  @override
  Future<List<DailyProgress>> getDailyProgressInRange(
      String userId, DateTime start, DateTime end) async {
    final snapshot = await _firestore
        .collection('daily_progress')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('date')
        .get();

    return snapshot.docs
        .map((doc) => DailyProgress.fromFirestore(doc))
        .toList();
  }
}