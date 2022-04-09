import 'package:charted/models/chart.dart';
import 'package:charted/models/iteration.dart';
import 'package:charted/pages/login.dart';
import 'package:charted/services/database_service.dart';
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
  final DatabaseService _db = DatabaseService();

  //var lastIterations = DatabaseService().getLastITerations();
  var lastIterations = {};

  @override
  void initState() {
    super.initState();
    getIterations();
  }

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
      body: StreamBuilder<Map<String, Chart>>(
          stream: _db.charts,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("An error has occured!"),
              );
            } else {
              var iterations = _db.getLastIterations();
              var keys = iterations.keys.toList();

              return keys.isNotEmpty
                  ? ListView.builder(
                      itemCount: iterations.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentIteration = iterations[keys[index]];

                        return Card(
                            elevation: 5.0,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.library_music),
                                    title: Text(currentIteration!.name),
                                    subtitle:
                                        Text(currentIteration.description),
                                  ),
                                ]));
                      })
                  : const Center(
                      child: Text("No charts have been made yet."),
                    );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCreateChart();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void getIterations() {
    lastIterations = DatabaseService().getLastIterations();
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
