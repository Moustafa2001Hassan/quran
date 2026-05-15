import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_journey/app/presentation/quran_journey_app.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';

import 'fakes/fake_auth_repository.dart';

void main() {
  testWidgets('Quran Journey app builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => FakeAuthRepository()),
        ],
        child: const QuranJourneyApp(themeMode: ThemeMode.light),
      ),
    );
    await tester.pump(const Duration(milliseconds: 900));
    expect(find.textContaining('Quran Journey'), findsWidgets);
  });
}
