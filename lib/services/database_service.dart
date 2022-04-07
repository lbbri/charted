import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService() {
    // _firestore.collection('users').snapshots().listen(_usersUpdated);
    // _firestore.collection('posts').snapshots().listen(_postsUpdated);
  }

  Future<void> addUser(String uid, String email, String displayName) async {
    await _firestore.collection("users").doc(uid).set({
      "display_name": displayName,
      "email": email,
      "created": DateTime.now()
    });
    return;
  }
}
