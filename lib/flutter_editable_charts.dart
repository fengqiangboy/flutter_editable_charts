import 'dart:async';

import 'package:flutter/services.dart';

class FlutterEditableCharts {
  static const MethodChannel _channel =
      const MethodChannel('flutter_editable_charts');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
