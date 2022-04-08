import 'package:charted/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateChartForm extends StatefulWidget {
  const CreateChartForm({
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Function onTap;
  @override
  State<CreateChartForm> createState() => _CreateChartFormState();
}

class _CreateChartFormState extends State<CreateChartForm> {
  var formKey = GlobalKey<FormState>();
  var loading = false;
  var name = TextEditingController();
  var description = TextEditingController();
  var isRanked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = DatabaseService();

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
                      _create();
                    },
                    child: const Text("Save Chart")),
              ],
            ),
          );
  }

  void _create() {
    db.addChart(_auth.currentUser!.uid, name.text, description.text, isRanked);
    widget.onTap();
  }
}
