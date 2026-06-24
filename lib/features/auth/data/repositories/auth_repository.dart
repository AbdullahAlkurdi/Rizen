import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
    : _auth = auth,
      _googleSignIn = googleSignIn;

  final FirebaseAuth? _auth;
  final GoogleSignIn? _googleSignIn;

  Stream<User?> authStateChanges() {
    return _auth?.authStateChanges() ?? const Stream.empty();
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('FirebaseAuth not initialized');
    }
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('FirebaseAuth not initialized');
    }
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(displayName);
    return credential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = _googleSignIn;
    if (googleSignIn == null) {
      throw StateError('GoogleSignIn not initialized');
    }
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final auth = _auth;
    if (auth == null) {
      throw StateError('FirebaseAuth not initialized');
    }
    return auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    final auth = _auth;
    final googleSignIn = _googleSignIn;
    if (auth != null && googleSignIn != null) {
      await Future.wait([auth.signOut(), googleSignIn.signOut()]);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final auth = _auth;
    if (auth == null) {
      throw StateError('FirebaseAuth not initialized');
    }
    await auth.sendPasswordResetEmail(email: email);
  }
}
