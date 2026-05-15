import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quran_journey/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> signInWithGoogle() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      return;
    }
    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'google-missing-id-token',
        message: 'Google Sign-In did not return an ID token. Check Firebase Console → Authentication → Google, '
            'and SHA-1 / OAuth client setup for Android.',
      );
    }
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: auth.accessToken,
    );
    await _auth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await Future.wait<void>([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
