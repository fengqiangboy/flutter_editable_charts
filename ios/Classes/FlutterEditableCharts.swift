//
//  FlutterEditableCharts.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import UIKit

class FlutterEditableCharts: NSObject ,FlutterPlatformView {
    
    let frame: CGRect
    
    let viewIdentifier: Int64
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) {
        self.frame = frame
        self.viewIdentifier = viewId
    }
    
    func view() -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.red
        return view
    }
}
