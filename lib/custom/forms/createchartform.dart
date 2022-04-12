import 'package:charted/models/iteration.dart';
import 'package:charted/services/database_service.dart';
import 'package:charted/services/spotify_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateChartForm extends StatefulWidget {
  const CreateChartForm({
    required this.onTap,
    this.chartId,
    Key? key,
  }) : super(key: key);
  final Function onTap;
  final String? chartId;
  @override
  State<CreateChartForm> createState() => _CreateChartFormState();
}

class _CreateChartFormState extends State<CreateChartForm> {
  bool editing = false;
  var formKey = GlobalKey<FormState>();
  var loading = true;
  var name = TextEditingController();
  var description = TextEditingController();
  var isRanked = false;
  Iteration? currentIteration;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = DatabaseService();

  @override
  void initState() {
    super.initState();
    getIteration();
  }

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
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: 'Chart Name',
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return "Name cannot be empty";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: description,
                    decoration:
                        const InputDecoration(hintText: 'Chart description'),
                  ),
                ),
                Switch(
                    value: isRanked,
                    onChanged: (value) {
                      setState(() {
                        isRanked = value;
                      });
                    }),
                Text(isRanked ? 'ranked' : 'unranked'),
                ElevatedButton(
                    onPressed: () {
                      editing ? _update() : _create();
                    },
                    child: const Text("Save Chart")),
                ElevatedButton(
                    onPressed: () {
                      testConnection();
                    },
                    child: const Text("Test Connection")),
              ],
            ),
          );
  }

  void _create() {
    db.addChart(_auth.currentUser!.uid, name.text, description.text, isRanked);
    widget.onTap();
  }

  void _update() {
    db.addIteration(widget.chartId!, name.text, description.text, isRanked);
    widget.onTap();
  }

  void getIteration() async {
    if (widget.chartId != null) {
      db.getIterationFromChart(widget.chartId!).then((iteration) {
        currentIteration = iteration;
        name.text = currentIteration!.name;
        description.text = currentIteration!.description;
        isRanked = currentIteration!.ranked;
        setState(() {
          currentIteration;
          editing = true;
          loading = false;
        });
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void testConnection() {
    final spot = SpotifyService();

    spot.testConnection();
  }
}
