import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingCompleteProvider =
    NotifierProvider<OnboardingCompleteNotifier, bool>(OnboardingCompleteNotifier.new);

class OnboardingCompleteNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void complete() => state = true;

  void reset() => state = false;
}
