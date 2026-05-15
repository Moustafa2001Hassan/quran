import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_journey/core/theme/app_spacing.dart';
import 'package:quran_journey/features/auth/presentation/auth_routes.dart';
import 'package:quran_journey/features/auth/presentation/providers/auth_providers.dart';
import 'package:quran_journey/features/auth/presentation/utils/auth_validators.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_divider_with_label.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_form_card.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_google_sign_in_button.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_screen_shell.dart';
import 'package:quran_journey/features/auth/presentation/widgets/auth_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _googleLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
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

  Future<void> _google() async {
    setState(() => _googleLoading = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(_messageForCode(e))));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _googleLoading = false);
    }
  }

  String _messageForCode(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email or password is incorrect.';
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return e.message ?? 'Sign-in failed. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      title: 'Welcome back',
      subtitle: 'Sign in to continue your memorization journey.',
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
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  validator: AuthValidators.password,
                  onFieldSubmitted: (_) => _submit(),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AuthRoutes.forgotPassword),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                AuthPrimaryButton(
                  label: 'Sign in',
                  loading: _loading,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSpacing.lg),
                const AuthDividerWithLabel(label: 'or'),
                const SizedBox(height: AppSpacing.lg),
                AuthGoogleSignInButton(
                  label: 'Continue with Google',
                  loading: _googleLoading,
                  onPressed: _google,
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New here?', style: Theme.of(context).textTheme.bodyMedium),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(AuthRoutes.signUp),
                      child: const Text('Create an account'),
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
