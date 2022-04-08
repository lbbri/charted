import 'package:charted/custom/forms/createchartform.dart';
import 'package:flutter/material.dart';

class CreateChartPage extends StatefulWidget {
  static const String routeName = '/create-charts';

  const CreateChartPage({Key? key}) : super(key: key);
  @override
  State<CreateChartPage> createState() => _CreateChartPageState();
}

class _CreateChartPageState extends State<CreateChartPage> {
  // List<ChatPreview> chatPreviews =
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
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'create chart',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              CreateChartForm(onTap: () => _successfulCreation(context)),
            ])));
  }

  static void _successfulCreation(BuildContext context) {
    Navigator.pop(context);
  }
}
