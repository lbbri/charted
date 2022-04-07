import 'package:charted/pages/home.dart';
import 'package:charted/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Driver extends StatelessWidget {
  Driver({Key? key}) : super(key: key);
  static const String routeName = '/driver';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var stream = _auth.idTokenChanges();
    stream.listen((event) {});
    if (_auth.currentUser != null) {
      return const HomePage();
    } else {
      return const LogInPage();
    }
  }
}
