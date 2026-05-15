import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/core/theme/app_styles.dart';
import 'package:quran_journey/features/auth/presentation/auth_navigator.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:quran_journey/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:quran_journey/features/onboarding/presentation/providers/onboarding_providers.dart';

/// Onboarding → Firebase auth → Dashboard.
class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingDone = ref.watch(onboardingCompleteProvider);
    if (!onboardingDone) {
      return const OnboardingScreen();
    }

    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
      data: (user) => user != null ? const HomePageRedirect() : const AuthNavigator(),
      loading: () => const _AuthBootstrapScaffold(),
      error: (e, _) => _AuthBootstrapError(message: e.toString()),
    );
  }
}

class _AuthBootstrapScaffold extends StatelessWidget {
  const _AuthBootstrapScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text('Preparing your session…', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _AuthBootstrapError extends StatelessWidget {
  const _AuthBootstrapError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppStyles.screenPadding(context),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_outlined, size: 48, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 16),
              Text(
                'Could not reach authentication services.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SelectableText(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              Text(
                'Add Firebase to this project (google-services.json / GoogleService-Info.plist and '
                'flutterfire configure), then restart the app.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Redirects authenticated users to the Dashboard.
class HomePageRedirect extends ConsumerWidget {
  const HomePageRedirect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DashboardPage();
  }
}