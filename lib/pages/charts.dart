import 'package:charted/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatefulWidget {
  static const String routeName = '/charts';

  const ChartsPage({Key? key}) : super(key: key);
  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'Charts',
                        //widget.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    logout();
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Text('charts page'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCreateChart();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openCreateChart() {
    Navigator.pushNamed(context, '/create-charts');
  }

  void logout() async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const LogInPage()),
      ModalRoute.withName('/'),
    );
  }
}
