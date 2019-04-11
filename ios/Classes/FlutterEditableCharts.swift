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
    
    let lineView: LineSetView
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, binaryMessenger: FlutterBinaryMessenger, arguments args: Any?) {
        self.frame = frame
        self.viewIdentifier = viewId
        self.methodChannel = FlutterMethodChannel(name: "com.timeyaa.com/flutter_editable_charts_\(viewId)",
            binaryMessenger: binaryMessenger)
        self.lineView = LineSetView(frame: frame)
        super.init()
        
        self.methodChannel.setMethodCallHandler { [weak self] (methodCall, result) in
            self?.onMethodCall(call: methodCall, result: result)
        }
    }
    
    func view() -> UIView {
        return lineView
    }
    
    /// dart 调用本地方法
    ///
    /// - Parameters:
    ///   - call: 调用方法的信息
    ///   - result: 调用之后的方法结果
    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch call.method {
        case "getData":
            getData(result: result)
        default:
            result(nil)
//            result(FlutterMethodNotImplemented)
        }
    }
    
    /// 获取数据
    ///
    /// - Parameter result: 返回给dart的结果
    func getData(result: FlutterResult) {
        let lineData = lineView.lineData
        
        let jsonLineData = lineData.map { (d) -> String in
            let resultData = try! JSONEncoder().encode(d)
            return String(data: resultData, encoding: .utf8)!
        }
        
        result(jsonLineData)
    }
    
}
