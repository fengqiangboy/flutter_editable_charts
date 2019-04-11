//
//  FlutterEditableChartsFactory.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import Foundation

class FlutterEditableChartsFactory: NSObject, FlutterPlatformViewFactory {
    
    let binaryMessenger: FlutterBinaryMessenger
    
    init(withBinaryMessenger binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterEditableCharts(withFrame: frame, viewIdentifier: viewId, binaryMessenger: binaryMessenger, arguments: args)
    }
    
}
