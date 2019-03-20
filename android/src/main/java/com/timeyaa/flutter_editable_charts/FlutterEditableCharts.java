package com.timeyaa.flutter_editable_charts;

import android.content.Context;
import android.view.View;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterEditableCharts implements PlatformView, MethodChannel.MethodCallHandler {

    private final MethodChannel methodChannel;

    private final Context context;

    public FlutterEditableCharts(Context context, BinaryMessenger messenger, int id) {
        this.context = context;
        methodChannel = new MethodChannel(messenger, "com.timeyaa.com/flutter_editable_charts_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

    }

    @Override
    public View getView() {
        return null;
    }

    @Override
    public void dispose() {

    }
}
