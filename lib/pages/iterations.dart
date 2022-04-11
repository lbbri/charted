import 'package:charted/custom/forms/createchartform.dart';
import 'package:charted/models/chart.dart';
import 'package:charted/models/iteration.dart';
import 'package:charted/pages/createchart.dart';
import 'package:charted/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IterationsPage extends StatefulWidget {
  static const String routeName = '/iterations';

  final String name;
  final String chartID;

  IterationsPage({
    Key? key,
    required this.name,
    required this.chartID,
  }) : super(key: key);

  //const IterationsPage({Key? key}) : super(key: key);
  @override
  State<IterationsPage> createState() => _IterationsPageState();
}

class _IterationsPageState extends State<IterationsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  //var lastIterations = DatabaseService().getLastITerations();
  var lastIterations = {};

  @override
  void initState() {
    super.initState();
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
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _openEditChart();
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Text('this is a testttt'),
    );
  }

  void _openEditChart() {
    // Navigator.pushNamed(context, '/create-charts',
    //     arguments: {'chartId': widget.chartID});
    String id = widget.chartID;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateChartPage(
                  chartId: widget.chartID,
                )));
  }
}
