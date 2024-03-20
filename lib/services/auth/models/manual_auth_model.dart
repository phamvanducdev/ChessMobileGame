import 'package:chess_mobile_game/enums/sign_in_method.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';

class ManualAuthModel extends AuthModel {
  final String email;
  final String password;
  final LoginMethod methodType = LoginMethod.manual;

  @override
  ManualAuthModel({
    required this.email,
    required this.password,
  }) : super();
}
