package com.timeyaa.flutter_editable_charts;

import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterEditableChartsPlugin {

    public static void registerWith(Registrar registrar) {
        registrar
                .platformViewRegistry()
                .registerViewFactory("com.timeyaa.com/flutter_editable_charts",
                        new FlutterEditableChartsFactory(registrar.messenger()));
    }
}
