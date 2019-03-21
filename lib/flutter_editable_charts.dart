import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_editable_charts/line_data_model.dart';

export 'package:flutter_editable_charts/line_data_model.dart';

/// 创建完成回调
typedef void FlutterEditableChartsCreatedCallback(
    FlutterEditableChartsController controller);

class FlutterEditableCharts extends StatefulWidget {
  /// 创建完成回调，在这里可以拿到controller
  final FlutterEditableChartsCreatedCallback onCreatedCallback;

  /// 开始拖动图表
  final Function onStart;

  /// 拖拽中
  final Function onChanging;

  /// 拖拽完成
  final Function onFinish;

  /// 初始化的x坐标最小值
  final double initMinX;

  /// 初始化的x坐标最大值
  final double initMaxX;

  /// 初始化的X坐标点数
  final int initXLabelCount;

  /// 初始化的x坐标最小间距
  final double initXSpaceMin;

  /// 初始化Y的最小坐标
  final double initMinY;

  /// 初始化的y都最大坐标
  final double initMaxY;

  /// 初始化的网格背景
  final Color initGridBackgroundColor;

  ///初始化的坐标轴文字颜色
  final Color initXAxisTextColor;

  /// 初始化的左坐标轴文字颜色
  final Color initAxisLeftTextColor;

  /// 初始化的值文字颜色
  final Color initValueTextColor;

  /// 初始化的值圆圈颜色
  final Color initValueCircleColor;

  /// 初始化的线条颜色
  final Color initValueColor;

  /// 初始化的背景颜色
  final Color initBackgroundColor;

  /// 初始化使用的数据
  final List<LineDataModel> initData;

  const FlutterEditableCharts({
    Key key,
    this.onCreatedCallback,
    this.onStart,
    this.onChanging,
    this.onFinish,
    this.initMinX = 0,
    this.initMaxX = 10,
    this.initXLabelCount = 10,
    this.initXSpaceMin = 1,
    this.initMinY = 0,
    this.initMaxY = 50,
    this.initData,
    this.initGridBackgroundColor = Colors.black,
    this.initXAxisTextColor = Colors.black,
    this.initAxisLeftTextColor = Colors.black,
    this.initValueTextColor = Colors.white,
    this.initValueCircleColor = Colors.white,
    this.initValueColor = Colors.white,
    this.initBackgroundColor = Colors.blueGrey,
  }) : super(key: key);

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

  void _onPlatformViewCreated(int id) async {
    var controller = FlutterEditableChartsController._(
      id,
      onStart: widget.onStart,
      onChanging: widget.onChanging,
      onFinish: widget.onFinish,
    );

    /// 初始化颜色
    await controller.setLineStyle(
        gridBackgroundColor: widget.initGridBackgroundColor,
        xAxisTextColor: widget.initXAxisTextColor,
        axisLeftTextColor: widget.initAxisLeftTextColor,
        valueTextColor: widget.initValueTextColor,
        valueCircleColor: widget.initValueCircleColor,
        valueColor: widget.initValueColor,
        backgroundColor: widget.initBackgroundColor);

    /// 设置初始化的坐标参数
    await controller.setLineBoundaryData(
        widget.initMinX,
        widget.initMaxX,
        widget.initXLabelCount,
        widget.initXSpaceMin,
        widget.initMinY,
        widget.initMaxY);

    /// 设置初始化数据
    var data = widget.initData ?? [LineDataModel(x: 0, y: 0)];
    await controller.setData(data);

    if (widget.onCreatedCallback == null) {
      return;
    }

    widget.onCreatedCallback(controller);
  }
}

class FlutterEditableChartsController {
  MethodChannel _channel;

  /// 开始拖动图表
  Function _onStart;

  /// 拖拽中
  Function _onChanging;

  /// 拖拽完成
  Function _onFinish;

  FlutterEditableChartsController._(int id,
      {Function onStart, Function onChanging, Function onFinish}) {
    _channel = MethodChannel('com.timeyaa.com/flutter_editable_charts_$id');
    _channel.setMethodCallHandler(methodHandler);
    _onStart = onStart;
    _onChanging = onChanging;
    _onFinish = onFinish;
  }

  Future<dynamic> methodHandler(MethodCall call) {
    switch (call.method) {
      case "onStart":
        if (_onStart != null) {
          _onStart();
        }
        break;
      case "onChanging":
        if (_onChanging != null) {
          _onChanging();
        }
        break;
      case "onFinish":
        if (_onFinish != null) {
          _onFinish();
        }
        break;
    }

    return null;
  }

  /// 获取曲线上面当前的数据
  Future<List<LineDataModel>> getData() async {
    var result = await _channel.invokeMethod("getData");
    if (!(result is List)) {
      return null;
    }

    var datas = List<LineDataModel>();

    result.forEach((jsonStr) {
      var model = LineDataModel.fromJson(json.decode(jsonStr));
      datas.add(model);
    });

    return datas;
  }

  /// 给曲线设置数据
  /// [datas] 要设置的数据点
  Future<void> setData(List<LineDataModel> datas) async {
    List jsonModels =
        datas.map((model) => json.encode(model.toJson())).toList();

    await _channel.invokeMethod("setData", <String, List>{"data": jsonModels});
  }

  /// 设置曲线边界值
  /// [minX] x最小值
  /// [maxX] x最大值
  /// [xLabelCount] x坐标点数
  /// [xSpaceMin] x坐标最小间隔
  /// [minY] y最小值
  /// [maxY] y最大值
  Future<void> setLineBoundaryData(double minX, double maxX, int xLabelCount,
      double xSpaceMin, double minY, double maxY) async {
    await _channel.invokeMethod(
      "setLineBoundaryData",
      <String, num>{
        "minX": minX,
        "maxX": maxX,
        "minY": minY,
        "maxY": maxY,
        "xLabelCount": xLabelCount,
        "xSpaceMin": xSpaceMin
      },
    );
  }

  Future<void> setLineStyle(
      {@required Color gridBackgroundColor,
      @required Color xAxisTextColor,
      @required Color axisLeftTextColor,
      @required Color valueTextColor,
      @required Color valueCircleColor,
      @required Color valueColor,
      @required Color backgroundColor}) async {
    await _channel.invokeMethod("setLineStyle", <String, int>{
      "gridBackgroundColor": gridBackgroundColor.value,
      "xAxisTextColor": xAxisTextColor.value,
      "axisLeftTextColor": axisLeftTextColor.value,
      "valueTextColor": valueTextColor.value,
      "valueCircleColor": valueCircleColor.value,
      "valueColor": valueColor.value,
      "backgroundColor": backgroundColor.value
    });
  }
}
