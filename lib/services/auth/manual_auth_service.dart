import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/services/auth/auth_service.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';
import 'package:chess_mobile_game/services/auth/models/manual_auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as package;

class ManualAuthService implements AuthService {
  @override
  Future<User?> signIn(AuthModel params) async {
    if (params is! ManualAuthModel) return null;
    final userCredential = await package.FirebaseAuth.instance.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    final authUser = userCredential.user;
    if (authUser == null) return null;
    return User(
      uid: authUser.uid,
      name: authUser.displayName,
      email: authUser.email,
    );
  }

  @override
  Future<User?> signUp(AuthModel params) async {
    return null;
  }
}
