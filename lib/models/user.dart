import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String? name;
  final String? email;

  User({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final snapshotData = snapshot.data() as Map<String, dynamic>;
    return User(
      uid: snapshot.id,
      name: snapshotData['name'],
      email: snapshotData['email'],
    );
  }

  Map<String, dynamic> toJsonDocument() {
    return {
      'name': name,
      'email': email,
    };
  }
}
