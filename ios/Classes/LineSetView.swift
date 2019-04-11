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
        let chartView = LineChartView()
        chartView.gridBackgroundColor = NSUIColor.white
        chartView.chartDescription?.text = ""
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 4.5
        chartView.xAxis.labelCount = 10
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 200
        chartView.leftAxis.labelTextColor = .white
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        
        return chartView
    } ()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = self.bounds
    }
    
}
