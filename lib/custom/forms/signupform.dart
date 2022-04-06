import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Function onTap;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var formKey = GlobalKey<FormState>();
  var loading = false;
  var email = TextEditingController();
  var password = TextEditingController();
  var displayName = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
                    controller: displayName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Screen Name',
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return "Screen Name cannot be empty";
                      }
                    },
                  ),
                ),
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
                      var pattern =
                          '[a-zA-Z0-9_.-]{1,}[@]{1}[a-zA-Z0-9_.-]{1,}[.][a-zA-Z0-9_.-]{1,}';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return "Enter Valid Email";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null) {
                        return "Password cannot be empty";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Retype Password',
                    ),
                    validator: (String? value) {
                      if (value != password.text) {
                        return "Passwords must match";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text("Sign Up"),
                  onPressed: () {
                    setState(() {
                      loading = true;
                      _signUp();
                    });
                  },
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: const Text("Existing User? Log In"))
              ],
            ),
          );
  }

  void _signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        ScaffoldMessenger.of(context).clearSnackBars();
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Unknown Error")));

        setState(() {
          loading = false;
        });
        return;
      }
      try {
        await _db.collection("users").doc(_auth.currentUser!.uid).set({
          "email": email.text, //redundant?
          "display_name": displayName.text,
        });

        widget.onTap();
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Unknown Error")));

        setState(() {
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
