import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/repositories/game_repository.dart';
import 'package:chess_mobile_game/services/firestore/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DependencyInjection {
  static List<InheritedProvider<dynamic>> get providers => [
        Provider<UserProvider>(create: (context) => UserProvider()),
        Provider<FirebaseAuth>(create: (context) => FirebaseAuth.instance),
        Provider<FirebaseFirestore>(create: (context) => FirebaseFirestore.instance),
        ProxyProvider<FirebaseFirestore, FirestoreService>(
          update: (context, firebaseFirestore, previous) =>
              previous ?? FirestoreServiceImpl(firebaseFirestore: firebaseFirestore),
        ),
        ProxyProvider<FirestoreService, AuthRepository>(
          update: (context, firestoreService, previous) => previous ?? AuthRepositoryImpl(firestoreService: firestoreService),
        ),
        ProxyProvider<FirestoreService, GameRepository>(
          update: (context, firestoreService, previous) => previous ?? GameRepositoryImpl(firestoreService: firestoreService),
        ),
      ];
}
