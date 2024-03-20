import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';
import 'package:chess_mobile_game/shared/base/base_bloc.dart';

class LoginBLoC implements BaseBLoC {
  final AuthRepository _authRepository;

  LoginBLoC({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<void> requestLogin(AuthModel params) async {
    await _authRepository.signIn(params);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
