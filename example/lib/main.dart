import 'package:flutter/material.dart';
import 'package:flutter_editable_charts/flutter_editable_charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterEditableChartsController _controller;

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
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterEditableCharts(
                    onCreatedCallback: (controller) => _controller = controller,
                    onStart: () => debugPrint("on start"),
                    onChanging: () => debugPrint("on changing"),
                    onFinish: () => debugPrint("on finish"),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  print(await _controller.getData());
                },
                child: Text("getData"),
              ),
              FlatButton(
                onPressed: _setData,
                child: Text("setData"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setData() {
    List<LineDataModel> models = [
      LineDataModel(x: 0, y: 13),
      LineDataModel(x: 1, y: 45),
      LineDataModel(x: 2, y: 26),
      LineDataModel(x: 3, y: 33),
      LineDataModel(x: 4, y: 24),
      LineDataModel(x: 5, y: 9),
      LineDataModel(x: 6, y: 13),
    ];

    _controller.setData(models);
  }
}
