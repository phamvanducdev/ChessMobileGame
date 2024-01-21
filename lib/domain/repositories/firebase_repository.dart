import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepository {
  Future<void> signin(String email, String password);
  Future<void> signup(String email, String password, String userName);
}

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseRepositoryImpl(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<void> signin(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signup(String email, String password, String userName) async {
    throw UnimplementedError();
  }
}
