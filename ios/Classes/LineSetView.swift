//
//  LineSetView.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import UIKit
import Charts

class LineSetView: UIView {
    
    var chartView: LineChartView = {
        return LineChartView()
    } ()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        chartView.backgroundColor = UIColor.yellow
        addSubview(chartView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = self.bounds
    }
    
}
