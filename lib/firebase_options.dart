// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBmlJeiWg_5JsCFWLVk1BqoFW7nebBsGT0',
    appId: '1:278312857856:web:e2ac9985c533b4a50e83e5',
    messagingSenderId: '278312857856',
    projectId: 'chess-mobile-game',
    authDomain: 'chess-mobile-game.firebaseapp.com',
    storageBucket: 'chess-mobile-game.appspot.com',
    measurementId: 'G-ZV53ZHCQH7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhU3XNG-2oPqzVBpj2NDECICPDHDepM98',
    appId: '1:278312857856:android:2e445e12f16dbf920e83e5',
    messagingSenderId: '278312857856',
    projectId: 'chess-mobile-game',
    storageBucket: 'chess-mobile-game.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDz1n9aYTu7lbDE_bWHPXQnq9M1Qp7faI',
    appId: '1:278312857856:ios:77a5a297df6c21dd0e83e5',
    messagingSenderId: '278312857856',
    projectId: 'chess-mobile-game',
    storageBucket: 'chess-mobile-game.appspot.com',
    iosBundleId: 'com.ducpv.chessMobileGame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDz1n9aYTu7lbDE_bWHPXQnq9M1Qp7faI',
    appId: '1:278312857856:ios:dd61a7308e8c11510e83e5',
    messagingSenderId: '278312857856',
    projectId: 'chess-mobile-game',
    storageBucket: 'chess-mobile-game.appspot.com',
    iosBundleId: 'com.ducpv.chessMobileGame.RunnerTests',
  );
}