import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quran_journey/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quran_journey/features/auth/domain/repositories/auth_repository.dart';

/// Provider for FirebaseAuth instance.
/// Uses late initialization to ensure Firebase is initialized first.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// Provider for GoogleSignIn instance.
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

/// Provider for AuthRepository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInProvider),
  );
});

/// Stream provider for auth state changes.
/// This will only start listening after Firebase is initialized.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.authStateChanges();
});
