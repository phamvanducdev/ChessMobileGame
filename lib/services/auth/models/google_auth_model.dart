import 'package:chess_mobile_game/enums/sign_in_method.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';

class GoogleAuthModel extends AuthModel {
  final LoginMethod methodType = LoginMethod.google;

  @override
  GoogleAuthModel() : super();
}
