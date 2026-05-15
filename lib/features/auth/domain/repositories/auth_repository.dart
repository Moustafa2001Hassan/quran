import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email, required String password});

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
