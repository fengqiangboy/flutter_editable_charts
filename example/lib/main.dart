import 'package:flutter/material.dart';
import 'package:flutter_editable_charts/flutter_editable_charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: FlutterEditableCharts(),
          ),
        ),
      ),
    );
  }
}
