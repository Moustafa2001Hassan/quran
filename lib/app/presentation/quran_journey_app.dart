import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_journey/app/presentation/app_entry.dart';
import 'package:quran_journey/core/theme/app_theme.dart';

/// Root [MaterialApp] for Quran Journey (themes + localization delegates).
class QuranJourneyApp extends StatelessWidget {
  const QuranJourneyApp({super.key, this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Journey',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      home: const AppEntry(),
    );
  }
}
