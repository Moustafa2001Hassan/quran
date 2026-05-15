import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/features/auth/presentation/auth_routes.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/auth/presentation/utils/auth_validators.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_text_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authRepositoryProvider).createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );
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
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'weak-password':
        return 'Please choose a stronger password.';
      default:
        return e.message ?? 'Could not create account.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      title: 'Create account',
      subtitle: 'Save progress across devices with a secure account.',
      child: AuthFormCard(
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthTextField(
                  controller: _email,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthPasswordField(
                  controller: _password,
                  label: 'Password',
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthPasswordField(
                  controller: _confirm,
                  label: 'Confirm password',
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: (v) => AuthValidators.confirmPassword(_password.text, v),
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: AppSpacing.lg),
                AuthPrimaryButton(
                  label: 'Sign up',
                  loading: _loading,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(AuthRoutes.login);
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
