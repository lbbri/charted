import 'package:charted/models/iteration.dart';
import 'package:charted/pages/createchart.dart';
import 'package:charted/services/database_service.dart';
import 'package:flutter/material.dart';

class IterationsPage extends StatefulWidget {
  static const String routeName = '/iterations';

  final String name;
  final String chartID;

  const IterationsPage({
    Key? key,
    required this.name,
    required this.chartID,
  }) : super(key: key);

  @override
  State<IterationsPage> createState() => _IterationsPageState();
}

class _IterationsPageState extends State<IterationsPage> {
  final DatabaseService _db = DatabaseService();
  bool loading = true;
  var chartIterations = {};

  @override
  void initState() {
    super.initState();
    _getIterations();
  }

  @override
  Widget build(BuildContext context) {
    var keys = chartIterations.keys.toList();
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
        body: loading
            ? const Text('loading')
            : ListView.builder(
                itemCount: chartIterations.length,
                itemBuilder: (BuildContext context, int index) {
                  Iteration currentIteration = chartIterations[keys[index]];

                  //bri: make this a custom widget
                  return GestureDetector(
                      onTap: () {
                        //pop up ieration modal
                      },
                      child: Card(
                          elevation: 5.0,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                    leading: const Icon(Icons.library_music),
                                    title: Text(currentIteration.name),
                                    subtitle: Text(currentIteration.created
                                        .toDate()
                                        .toString())),
                              ])));
                }));
  }

  void _openEditChart() {
    //?? is there any way I can use pushNamed with parameters
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateChartPage(
                  chartId: widget.chartID,
                )));
  }

  void _getIterations() async {
    chartIterations = await _db.getChartIterations(widget.chartID);
    setState(() {
      chartIterations;
      loading = false;
    });
  }
}
