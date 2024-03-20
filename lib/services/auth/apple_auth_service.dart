import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/services/auth/auth_service.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';

class AppleAuthService implements AuthService {
  @override
  Future<User?> signIn(AuthModel params) async {
    return null;
  }

  @override
  Future<User?> signUp(AuthModel params) {
    throw UnimplementedError();
  }
}
