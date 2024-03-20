import 'package:chess_mobile_game/models/game.dart';
import 'package:chess_mobile_game/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCollectionPath {
  static const String users = 'users';
  static const String games = 'games';
}

abstract class FirestoreService {
  Future<User?> getUserInfo(String uid);
  Future<void> setUserInfo(User userInfo);
  Future<void> createNewGame(Game game);
  Future<void> updateGameState(Game game);
  Stream<Game?> getGameStream(String gid);
}

class FirestoreServiceImpl extends FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreServiceImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<User?> getUserInfo(String uid) async {
    final reference = _firebaseFirestore.collection(FirebaseCollectionPath.users).doc(uid);
    final snapshot = await reference.get();
    if (snapshot.exists) {
      return User.fromDocumentSnapshot(snapshot);
    }
    return null;
  }

  @override
  Future<void> setUserInfo(User userInfo) async {
    final reference = _firebaseFirestore.collection(FirebaseCollectionPath.users).doc(userInfo.uid);
    return reference.set(userInfo.toJsonDocument());
  }

  @override
  Future<void> createNewGame(Game game) async {
    final reference = _firebaseFirestore.collection(FirebaseCollectionPath.games).doc(game.gid);
    await reference.set(game.toJsonDocument());
  }

  @override
  Future<void> updateGameState(Game game) {
    final reference = _firebaseFirestore.collection(FirebaseCollectionPath.games).doc(game.gid);
    return reference.update(game.toJsonDocument());
  }

  @override
  Stream<Game?> getGameStream(String gid) {
    final reference = _firebaseFirestore.collection(FirebaseCollectionPath.games).doc(gid);
    return reference.snapshots().map((snapshot) => snapshot.exists ? Game.fromSnapshot(snapshot) : null);
  }
}
