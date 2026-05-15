import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/features/auth/presentation/auth_routes.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/auth/presentation/utils/auth_validators.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_text_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;
  bool _sent = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email: _email.text);
      setState(() => _sent = true);
    } on FirebaseAuthException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(_messageForCode(e))));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _messageForCode(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for this email.';
      case 'invalid-email':
        return 'That email address looks invalid.';
      default:
        return e.message ?? 'Could not send reset email.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      title: 'Reset password',
      subtitle: _sent
          ? 'If an account exists for ${_email.text.trim()}, you will receive a link to reset your password.'
          : 'Enter your email and we will send you a reset link.',
      child: AuthFormCard(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_sent) ...[
                AuthTextField(
                  controller: _email,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.email],
                  validator: AuthValidators.email,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthPrimaryButton(
                  label: 'Send reset link',
                  loading: _loading,
                  onPressed: _submit,
                ),
              ] else ...[
                Icon(Icons.mark_email_read_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Check your inbox and spam folder.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.xl),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(AuthRoutes.login),
                  child: const Text('Back to sign in'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
