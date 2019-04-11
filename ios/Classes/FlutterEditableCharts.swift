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
    
    let lineSetView: LineSetView
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, binaryMessenger: FlutterBinaryMessenger, arguments args: Any?) {
        self.frame = frame
        self.viewIdentifier = viewId
        self.methodChannel = FlutterMethodChannel(name: "com.timeyaa.com/flutter_editable_charts_\(viewId)",
            binaryMessenger: binaryMessenger)
        self.lineSetView = LineSetView(frame: frame)
        super.init()
        
        self.methodChannel.setMethodCallHandler { [weak self] (methodCall, result) in
            self?.onMethodCall(call: methodCall, result: result)
        }
    }
    
    func view() -> UIView {
        return lineSetView
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
        case "setData":
            setData(call: call, result: result)
        case "setLineBoundaryData":
            setLineBoundaryData(call: call, result: result)
        case "setLineStyle":
            setLineStyle(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// 获取数据
    func getData(result: FlutterResult) {
        let lineData = lineSetView.lineData
        let jsonEncoder = JSONEncoder()
        let jsonLineData = lineData.map { (d) -> String in
            let resultData = try! jsonEncoder.encode(d)
            return String(data: resultData, encoding: .utf8)!
        }
        
        result(jsonLineData)
    }
    
    /// 设置数据
    func setData(call: FlutterMethodCall, result: FlutterResult) {
        guard let datasArgs = (call.arguments as? [String: [String]])?["data"] else { return }
        let jsonDecoder = JSONDecoder()
        lineSetView.lineData = datasArgs.map { (dataJsonStr) in
            try! jsonDecoder.decode(LineDataModel.self, from: dataJsonStr.data(using: .utf8)!)
        }
        
        result(nil)
    }
    
    /// 设置边界值
    func setLineBoundaryData(call: FlutterMethodCall, result: FlutterResult) {
        result(nil)
    }
    
    /// 设置线条样式
    func setLineStyle(call: FlutterMethodCall, result: FlutterResult) {
        result(nil)
    }
    
}
