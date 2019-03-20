import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class FlutterEditableCharts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlutterEditableChartsState();
  }
}

class FlutterEditableChartsState extends State<FlutterEditableCharts> {
  MethodChannel _channel;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
          viewType: "", onPlatformViewCreated: _onPlatformViewCreated);
    }

    return Text("iOS version is comming");
  }

  void _onPlatformViewCreated(int id) {
    _channel = new MethodChannel('com.timeyaa.com/flutter_editable_charts_$id');
  }
}
