import 'package:chess_mobile_game/services/auth/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as package;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/services/auth/auth_service.dart';

class GoogleAuthService implements AuthService {
  @override
  Future<User?> signIn(AuthModel params) async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final googleSignInAccount = await googleSignIn.signIn();
    final googleSignInAuthentication = await googleSignInAccount?.authentication;
    final credential = package.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    final userCredential = await package.FirebaseAuth.instance.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;
    return User(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
    );
  }

  @override
  Future<User?> signUp(AuthModel params) {
    throw UnimplementedError();
  }
}
