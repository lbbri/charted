import 'package:charted/pages/charts.dart';
import 'package:charted/pages/home.dart';
import 'package:charted/custom/forms/signupform.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String routeName = '/signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SignUpForm(onTap: () => _successfulSignUp(context)),
            ])));
  }

  static void _successfulSignUp(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const ChartsPage()),
      ModalRoute.withName('/'),
    );
  }
}
