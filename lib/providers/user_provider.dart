import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/services/storage/app_shared_pref.dart';

class UserProvider {
  static User? _userLogged;
  static User? get userLogged => _userLogged;

  static void initialize() async {
    setUserLogged(await AppSharedPref.getUserLogged());
  }

  static void setUserLogged(User? user) {
    _userLogged = user;
  }
}
