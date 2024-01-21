import 'package:chess_mobile_game/domain/repositories/firebase_repository.dart';

class SplashViewModel {
  final FirebaseRepository _firebaseRepository;

  SplashViewModel(this._firebaseRepository);

  initialize({
    required void Function() runApp,
  }) async {
    try {
      // Todo initialize app info.
      await Future.delayed(Duration(seconds: 3));
      runApp();
    } catch (e) {
      runApp();
      print('initialize failed: $e');
    }
  }
}
