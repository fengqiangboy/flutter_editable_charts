//
//  FlutterEditableCharts.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import UIKit

class FlutterEditableCharts: NSObject, FlutterPlatformView {
    
    let frame: CGRect
    
    let viewIdentifier: Int64
    
    let methodChannel: FlutterMethodChannel
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, binaryMessenger: FlutterBinaryMessenger, arguments args: Any?) {
        self.frame = frame
        self.viewIdentifier = viewId
        self.methodChannel = FlutterMethodChannel(name: "com.timeyaa.com/flutter_editable_charts_\(viewId)",
            binaryMessenger: binaryMessenger)
        super.init()
        
        self.methodChannel.setMethodCallHandler { [weak self] (methodCall, result) in
            self?.onMethodCall(call: methodCall, result: result)
        }
    }
    
    func view() -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.red
        return view
    }
    
    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        print(call.method)
        result(nil)
    }
    
}
