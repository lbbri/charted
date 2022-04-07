import 'package:charted/pages/home.dart';
import 'package:charted/custom/forms/loginform.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Log In"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              LogInForm(onTap: () => _successfulLogIn(context)),
            ])));
  }

  static void _successfulLogIn(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
      ModalRoute.withName('/'),
    );
  }
}
