import 'package:flutter/material.dart';
import 'package:quran_journey/core/theme/app_styles.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.verseCard(context),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: child,
      ),
    );
  }
}
