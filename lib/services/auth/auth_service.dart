import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';

abstract class AuthService {
  Future<User?> signIn(AuthModel params);
  Future<User?> signUp(AuthModel params);
}
