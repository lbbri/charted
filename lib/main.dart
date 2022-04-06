import 'package:charted/routes/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'driver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initializer = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Charted',
        onGenerateRoute: AppRouter.generateRoute,
        home: FutureBuilder<FirebaseApp>(
          future: _initializer,
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Driver();
            } else {
              return const Text('testing');
            }
          },
        ));
  }
}
