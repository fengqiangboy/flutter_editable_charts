//
//  LineSetView.swift
//  flutter_editable_charts
//
//  Created by 奉强 on 2019/4/11.
//

import UIKit
import Charts

class LineSetView: UIView {
    
    var panGesture: UIPanGestureRecognizer?
    
    lazy var chartView: LineChartView = {
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
        
        let data = LineChartData()
        data.addDataSet(dataSet)
        
        chartView.data = data
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(chartViewPan(_:)))
        chartView.addGestureRecognizer(panGesture!)
        
        return chartView
    } ()
    
    /// 数据集
    lazy var dataSet: LineChartDataSet = {
        var yse1 = [ChartDataEntry]()
        
        for x in stride(from: 0, to: 4.9, by: 0.5) {
            yse1.append(ChartDataEntry(x: Double(x), y: 15 * x))
        }
        
        let dataSet = LineChartDataSet(values: yse1, label: nil)
        dataSet.highlightEnabled = true // 选中拐点,是否开启高亮效果(显示十字线)
        dataSet.highlightColor = .clear // 十字线颜色
        dataSet.drawCirclesEnabled = true // 是否绘制拐点
        dataSet.cubicIntensity = 0.2 // 曲线弧度
        dataSet.circleRadius = 3 // 打点大小
        dataSet.circleColors = [UIColor.green] // 圆圈颜色
        dataSet.valueColors = [.white] // 数值颜色
        dataSet.valueFont = UIFont.systemFont(ofSize: 10)
        dataSet.mode = .cubicBezier // 模式为曲线模式
        dataSet.drawFilledEnabled = true // 是否填充颜色
        dataSet.drawValuesEnabled = true
        dataSet.lineWidth = 1.5 // 线宽
        
        dataSet.setColor(UIColor.green)
        
        let gradientColors = [
            UIColor.green.cgColor,
            UIColor.green.withAlphaComponent(0.7).cgColor,
            ] as CFArray
        
        let gradientRef = CGGradient(colorsSpace: nil, colors: gradientColors, locations: nil)
        dataSet.fillAlpha = 0.5
        dataSet.fill = Fill(linearGradient: gradientRef!, angle: 90)
        
        return dataSet
    }()
    
    var lineData: [LineDataModel] {
        set {
            let nDataSet = newValue.map { ChartDataEntry(x: $0.x, y: $0.y) }
            dataSet.values.removeAll(keepingCapacity: true)
            dataSet.values.append(contentsOf: nDataSet)
            
            chartView.xAxis.labelCount = newValue.count
            
            chartView.notifyDataSetChanged()
        }
        
        get {
            return dataSet.values.map { LineDataModel(x: $0.x, y: $0.y) }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(chartView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = self.bounds
    }
    
    /// 图表滑动
    ///
    /// - Parameter pan: 手势处理
    @objc func chartViewPan(_ pan: UIPanGestureRecognizer) {
        let view = pan.view as! LineChartView
        let value = view.valueForTouchPoint(point: pan.location(in: view), axis: .left)
        valueChange(to: value)
    }
    
    /// 值改变的时候的调用
    ///
    /// - Parameter value: 改变的新值
    private func valueChange(to value: CGPoint) {
        // 获取数据源
        guard let data = chartView.data?.getDataSetByIndex(0) else {
            return
        }
        
        // 遍历数据，获取最接近的那个
        for index in 0 ..< data.entryCount {
            guard let entry = data.entryForIndex(index) else {
                continue
            }
            
            if abs(entry.x - Double(value.x)) < 0.1 {
                entry.y = Double(value.y)
                break
            }
        }
        
        dataSet.notifyDataSetChanged()
    }
    
    func setLineBoundaryData(minX: Double, maxX: Double, xLabelCount: Int, xSpaceMin: Double, minY: Double, maxY: Double) {
        let xAxis = chartView.xAxis
        xAxis.axisMinimum = minX
        xAxis.axisMaximum = maxX
        xAxis.spaceMin = xSpaceMin
        xAxis.labelCount = xLabelCount
        
        let axisLeft = chartView.leftAxis
        axisLeft.axisMinimum = minY
        axisLeft.axisMaximum = maxY
        
        dataSet.notifyDataSetChanged()
    }
}
