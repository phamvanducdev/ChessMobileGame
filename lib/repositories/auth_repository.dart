import 'package:chess_mobile_game/models/user.dart';
import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/services/auth/auth_service.dart';
import 'package:chess_mobile_game/services/firestore/firestore_service.dart';
import 'package:chess_mobile_game/services/auth/models/auth_model.dart';
import 'package:chess_mobile_game/services/storage/app_shared_pref.dart';

abstract class AuthRepository {
  Future<void> signIn(AuthModel params);
  Future<void> signUp(AuthModel params);
  Future<void> signOut();
}

class AuthRepositoryImpl extends AuthRepository {
  final FirestoreService _firestoreService;

  AuthRepositoryImpl({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  @override
  Future<void> signIn(AuthModel params) async {
    AuthService authService = params.getService();
    User? userLogged = await authService.signIn(params);
    if (userLogged == null) return null;
    User? userFetched = await _firestoreService.getUserInfo(userLogged.uid);
    if (userFetched == null) {
      await _firestoreService.setUserInfo(userLogged);
      userFetched = userLogged;
    }
    await AppSharedPref.setUserLogged(userFetched);
    UserProvider.setUserLogged(userFetched);
  }

  @override
  Future<void> signUp(AuthModel params) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await AppSharedPref.setUserLogged(null);
    UserProvider.setUserLogged(null);
  }
}
