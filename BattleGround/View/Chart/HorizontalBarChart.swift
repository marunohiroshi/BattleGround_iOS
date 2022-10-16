////
////  HorizontalBarChart.swift
////  BattleGround
////
////  Created by 丸野拓志 on 2022/07/31.
////
//
// import Charts
// import SwiftUI
//
// struct HorizontalBarChart: UIViewRepresentable {
//    func makeUIView(context: Context) -> HorizontalBarChartView {
//        let chartView = HorizontalBarChartView()
//
//        chartView.drawBarShadowEnabled = false
//        chartView.drawValueAboveBarEnabled = true
//
//        chartView.maxVisibleCount = 60
//
//        let xAxis = chartView.xAxis
//        xAxis.labelPosition = .bottom
//        xAxis.labelFont = .systemFont(ofSize: 10)
//        xAxis.drawAxisLineEnabled = true
//        xAxis.granularity = 10
//
//        let leftAxis = chartView.leftAxis
//        leftAxis.labelFont = .systemFont(ofSize: 10)
//        leftAxis.drawAxisLineEnabled = true
//        leftAxis.drawGridLinesEnabled = true
//        leftAxis.axisMinimum = 0
//
//        let rightAxis = chartView.rightAxis
//        rightAxis.enabled = true
//        rightAxis.labelFont = .systemFont(ofSize: 10)
//        rightAxis.drawAxisLineEnabled = true
//        rightAxis.axisMinimum = 0
//
//        let legend = chartView.legend
//        legend.horizontalAlignment = .left
//        legend.verticalAlignment = .bottom
//        legend.orientation = .horizontal
//        legend.drawInside = false
//        legend.form = .square
//        legend.formSize = 8
//        legend.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
//        legend.xEntrySpace = 4
//
//        chartView.fitBars = true
//
//        chartView.data = setDataCount(12, range: 50)
//
//        chartView.animate(yAxisDuration: 2.5)
//
//        return chartView
//    }
//    func updateUIView(_ uiView: HorizontalBarChartView, context: Context) {
//    }
//
//    func setDataCount(_ count: Int, range: UInt32) -> BarChartData {
//        let barWidth = 9.0
//        let spaceForBar = 10.0
//
//        let yVals = (0..<count).map { index -> BarChartDataEntry in
//            let mult = range + 1
//            let val = Double(arc4random_uniform(mult))
//            return BarChartDataEntry(x: Double(index) * spaceForBar, y: val)
//        }
//
//        let set1 = BarChartDataSet(entries: yVals, label: "DataSet")
//        set1.drawIconsEnabled = false
//
//        let data = BarChartData(dataSet: set1)
//        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
//        data.barWidth = barWidth
//
//        return data
//    }
// }
