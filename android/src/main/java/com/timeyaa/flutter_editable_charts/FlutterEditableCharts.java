package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;

import com.github.mikephil.charting.utils.Utils;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterEditableCharts implements PlatformView, MethodChannel.MethodCallHandler {

    private final MethodChannel methodChannel;

    private final View view;

    public FlutterEditableCharts(Context context, BinaryMessenger messenger, int id) {
        Utils.init(context);

        this.view = new LineSetView(context);
        methodChannel = new MethodChannel(messenger, "com.timeyaa.com/flutter_editable_charts_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

    }

    @Override
    public View getView() {
        return view;
    }

    @Override
    public void dispose() {

    }
}
