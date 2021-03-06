import 'dart:async';

import 'package:charted/models/chart.dart';
import 'package:charted/models/iteration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  static Map<String, Chart> chartMap = <String, Chart>{};
  static Map<String, Iteration> lastIterationMap = <String, Iteration>{};

  final StreamController<Map<String, Chart>> _chartsController =
      StreamController<Map<String, Chart>>();

  DatabaseService() {
    _firestore
        .collection('charts')
        .where('user', isEqualTo: uid)
        .snapshots()
        .listen(_chartsUpdated);
  }

  Stream<Map<String, Chart>> get charts => _chartsController.stream;

  void _chartsUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var charts = _getChartsFromSnapshot(snapshot);
    _chartsController.add(charts);
  }

  Map<String, Chart> _getChartsFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      Chart chart = Chart.fromMap(element.id, element.data());
      chartMap[chart.id] = chart;
    }
    _setLastIterationsFromCharts(chartMap);
    return chartMap;
  }

  Future<void> _setLastIterationsFromCharts(Map<String, Chart> charts) async {
    for (var chart in charts.values) {
      var lastIteration = chart.lIteration;
      await _firestore
          .collection('iterations')
          .doc(lastIteration)
          .get()
          .then((value) {
        Iteration iteration = Iteration.fromMap(value.id, value.data()!);
        lastIterationMap[iteration.id] = iteration;
      });
    }
    return;
  }

  Future<Iteration?> getIterationFromChart(String chartId) async {
    var chartSnapshot =
        await _firestore.collection('charts').doc(chartId).get();
    var iterationId = chartSnapshot.data()!['last_iteration'];

    var iterationSnapshot =
        await _firestore.collection('iterations').doc(iterationId).get();
    Iteration iteration =
        Iteration.fromMap(iterationSnapshot.id, iterationSnapshot.data()!);
    return iteration;
  }

  Future<Map<String, Iteration>> getChartIterations(String chartId) async {
    Map<String, Iteration> iterations = {};

    var snapshots = await _firestore
        .collection('iterations')
        .where('chart', isEqualTo: chartId)
        .get();

    for (var iteration in snapshots.docs) {
      var currentIteration = Iteration.fromMap(iteration.id, iteration.data());
      iterations[currentIteration.id] = currentIteration;
    }
    return iterations;
  }

  Map<String, Iteration> getLastIterations() {
    return lastIterationMap;
  }

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
