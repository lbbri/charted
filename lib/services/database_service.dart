import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService();

  Future<void> addUser(String uid, String email, String displayName) async {
    await _firestore.collection("users").doc(uid).set({
      "display_name": displayName,
      "email": email,
      "created": DateTime.now()
    });
    return;
  }

  Future<void> addChart(String uid, String name,
      [String description = '', bool ranked = false]) async {
    await _firestore.collection("charts").add({
      "user": uid,
      "created": DateTime.now(),
      "last_iteration": '',
    }).then((value) {
      final chartId = value.id;
      addIteration(chartId, name, description, ranked);
    });
  }

  Future<void> addIteration(String chart, String name,
      [String description = '', bool ranked = false]) async {
    await _firestore.collection("iterations").add({
      "chart": chart,
      "name": name,
      "description": description,
      "ranked": ranked,
      "content": {},
      "created": DateTime.now()
    }).then((value) {
      _firestore
          .collection("charts")
          .doc(chart)
          .update({"last_iteration": value.id});
    });
  }
}
