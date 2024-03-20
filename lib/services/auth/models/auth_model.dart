import 'package:chess_mobile_game/services/auth/apple_auth_service.dart';
import 'package:chess_mobile_game/services/auth/google_auth_service.dart';
import 'package:chess_mobile_game/services/auth/auth_service.dart';
import 'package:chess_mobile_game/services/auth/manual_auth_service.dart';
import 'package:chess_mobile_game/services/auth/models/apple_auth_model.dart';
import 'package:chess_mobile_game/services/auth/models/google_auth_model.dart';

abstract class AuthModel {
  AuthModel();

  AuthService getService() {
    switch (runtimeType) {
      case AppleAuthModel:
        return AppleAuthService();
      case GoogleAuthModel:
        return GoogleAuthService();
      default:
        return ManualAuthService();
    }
  }
}
