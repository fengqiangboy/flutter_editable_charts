package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.view.View;

import com.alibaba.fastjson.JSON;
import com.github.mikephil.charting.utils.Utils;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterEditableCharts implements PlatformView, MethodChannel.MethodCallHandler {

    private final MethodChannel methodChannel;

    private final LineSetView view;

    public FlutterEditableCharts(Context context, BinaryMessenger messenger, int id) {
        Utils.init(context);

        this.view = new LineSetView(context);
        methodChannel = new MethodChannel(messenger, "com.timeyaa.com/flutter_editable_charts_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "getData":
                getData(result);
                break;

            case "setData":
                String data = methodCall.argument("data");
                List<LineDataModel> dataModel = JSON.parseArray(data, LineDataModel.class);
                view.setLineData(dataModel);
                result.success(null);
                break;

            default:
                result.notImplemented();
        }
    }

    @Override
    public View getView() {
        return view;
    }

    private void getData(MethodChannel.Result result) {
        List<LineDataModel> lineData = view.getLineData();
        List<String> jsonLineData = new ArrayList<>(lineData.size());
        for (LineDataModel data : lineData) {
            jsonLineData.add(JSON.toJSONString(data));
        }

        result.success(jsonLineData);
    }

    @Override
    public void dispose() {

    }
}
