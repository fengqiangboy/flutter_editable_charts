import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_editable_charts/line_data_model.dart';

typedef void FlutterEditableChartsCreatedCallback(
    FlutterEditableChartsController controller);

class FlutterEditableCharts extends StatefulWidget {
  final FlutterEditableChartsCreatedCallback onCreatedCallback;

  const FlutterEditableCharts({Key key, this.onCreatedCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => FlutterEditableChartsState();
}

class FlutterEditableChartsState extends State<FlutterEditableCharts> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
          viewType: "com.timeyaa.com/flutter_editable_charts",
          onPlatformViewCreated: _onPlatformViewCreated);
    }

    return Text("iOS version is comming");
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onCreatedCallback == null) {
      return;
    }

    widget.onCreatedCallback(FlutterEditableChartsController._(id));
  }
}

class FlutterEditableChartsController {
  MethodChannel _channel;

  FlutterEditableChartsController._(int id)
      : _channel = MethodChannel('com.timeyaa.com/flutter_editable_charts_$id');

  Future<List<LineDataModel>> getData() async {
    var result = await _channel.invokeMethod("getData");
    if (!(result is String)) {
      return null;
    }

    var models = List<LineDataModel>();
    var jsonRet = json.decode(result) as List;

    jsonRet.forEach((jsonObj) {
      var model = LineDataModel.fromJson(jsonObj);
      models.add(model);
    });

    return models;
  }
}
