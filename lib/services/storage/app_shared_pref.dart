import 'dart:convert';

import 'package:chess_mobile_game/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  AppSharedPref._();

  static const String keyUserLogged = 'keyUserLogged';

  static Future<bool> setUserLogged(User? userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userInfo == null) {
      return await prefs.remove(keyUserLogged);
    }
    return await prefs.setString(keyUserLogged, jsonEncode(userInfo.toJson()));
  }

  static Future<User?> getUserLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringJson = prefs.getString(keyUserLogged);
    if (stringJson == null || stringJson.isEmpty) {
      return null;
    }
    return User.fromJson(jsonDecode(stringJson));
  }
}
