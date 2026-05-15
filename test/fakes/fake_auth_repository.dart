import 'package:firebase_auth/firebase_auth.dart';
import 'package:quran_journey/features/auth/domain/repositories/auth_repository.dart';

/// Test double so widget tests do not touch Firebase.
class FakeAuthRepository implements AuthRepository {
  @override
  Stream<User?> authStateChanges() => Stream<User?>.value(null);

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      Future<void>.value();

  @override
  Future<void> sendPasswordResetEmail({required String email}) => Future<void>.value();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      Future<void>.value();

  @override
  Future<void> signInWithGoogle() => Future<void>.value();

  @override
  Future<void> signOut() => Future<void>.value();
}
