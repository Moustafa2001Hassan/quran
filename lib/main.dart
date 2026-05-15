import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/app/presentation/quran_journey_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e, st) {
    debugPrint('Firebase.initializeApp failed: $e\n$st');
  }
  runApp(const ProviderScope(child: QuranJourneyApp()));
}
