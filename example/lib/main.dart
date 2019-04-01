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

    var initValue = 180.0;
    var initData = [
      LineDataModel(x: 0, y: initValue),
      LineDataModel(x: 0.5, y: initValue),
      LineDataModel(x: 1, y: initValue),
      LineDataModel(x: 1.5, y: initValue),
      LineDataModel(x: 2, y: initValue),
      LineDataModel(x: 2.5, y: initValue),
      LineDataModel(x: 3, y: initValue),
      LineDataModel(x: 3.5, y: initValue),
      LineDataModel(x: 4, y: initValue),
      LineDataModel(x: 4.5, y: initValue),
    ];

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
                    initValueTextColor: Colors.red,
                    initValueColor: Colors.grey,
                    initBackgroundColor: Colors.white,
                    initMaxY: 300,
                    initMinY: 100,
                    initData: initData,
                    initXSpaceMin: 0.5,
                    initMaxX: 4.5,
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
              FlatButton(
                onPressed: _changeColor,
                child: Text("changeColor"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setData() async {
    List<LineDataModel> models = [
      LineDataModel(x: 0, y: 180),
      LineDataModel(x: 1, y: 180),
      LineDataModel(x: 2, y: 180),
      LineDataModel(x: 3, y: 180),
      LineDataModel(x: 4, y: 180),
      LineDataModel(x: 5, y: 180),
      LineDataModel(x: 6, y: 180),
    ];

    await _controller.setLineBoundaryData(0, 4.5, 10, 0.5, 100, 250);
    await _controller.setData(models);
  }

  void _changeColor() async {
    await _controller.setLineStyle(
        gridBackgroundColor: Colors.red,
        xAxisTextColor: Colors.red,
        axisLeftTextColor: Colors.red,
        valueTextColor: Colors.white,
        valueCircleColor: Colors.white,
        valueColor: Colors.red,
        backgroundColor: Colors.blue);
  }
}
