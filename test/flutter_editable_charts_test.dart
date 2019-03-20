import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_editable_charts/flutter_editable_charts.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_editable_charts');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterEditableCharts.platformVersion, '42');
  });
}
