import 'package:charted/custom/forms/signupform.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Function onTap;
  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  var formKey = GlobalKey<FormState>();
  var loading = false;
  var email = TextEditingController();
  var password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: Text('loading'))
        : Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return "Email cannot be empty";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return "Password cannot be empty";
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                        _login();
                      });
                    },
                    child: const Text("Log In")),
                TextButton(
                    onPressed: () {
                      showSignUp();
                    },
                    child: const Text("New User? Sign Up"))
              ],
            ),
          );
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        ScaffoldMessenger.of(context).clearSnackBars();
        widget.onTap();
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Unknown Error")));
        setState(() {
          loading = false;
        });
        return;
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void showSignUp() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.all(30.0),
              child: SignUpForm(onTap: widget.onTap));
        });
  }
}
