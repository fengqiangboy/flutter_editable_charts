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
                setData(methodCall, result);
                break;

            default:
                result.notImplemented();
        }
    }

    @Override
    public View getView() {
        return view;
    }

    /**
     * flutter 读取数据
     *
     * @param result 结果回调
     */
    private void getData(MethodChannel.Result result) {
        List<LineDataModel> lineData = view.getLineData();
        List<String> jsonLineData = new ArrayList<>(lineData.size());
        for (LineDataModel data : lineData) {
            jsonLineData.add(JSON.toJSONString(data));
        }

        result.success(jsonLineData);
    }

    /**
     * 给表设置数据
     *
     * @param methodCall 方法调用信息
     * @param result     结果回调
     */
    private void setData(MethodCall methodCall, MethodChannel.Result result) {
        List<String> argement = methodCall.argument("data");
        List<LineDataModel> dataModels = new ArrayList<>(argement.size());
        if (argement.size() != 0) {
            for (String argStr : argement) {
                dataModels.add(JSON.parseObject(argStr, LineDataModel.class));
            }
        }

        view.setLineData(dataModels);

        result.success(null);
    }

    @Override
    public void dispose() {

    }
}
