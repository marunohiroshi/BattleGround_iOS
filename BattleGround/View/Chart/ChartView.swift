//
//  ChartView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/22.
//

import Charts
import SwiftUI

struct ChartView: View {
    @State var isShowChart = false

    var body: some View {
        ScrollView {
            VStack {
                if isShowChart {
                    Spacer(minLength: 50)
                    Text("ポイント変動")
                    ChartViewControllerWrapper()
                        .frame(width: .infinity, height: 300)

                    Spacer(minLength: 50)

                    Text("ヒーロー使用回数")
                    PieChart()
                        .frame(width: .infinity, height: 300)

                    Spacer(minLength: 50)
                }
            }
        }
        .navigationBarTitle("") // this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            isShowChart = false
        }
        .onAppear {
            isShowChart = true
        }
    }
}

struct ChartViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ChartViewController {
        ChartViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // no-action
    }
}

class ChartViewController: UIViewController {
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!

    var logDataList: [LogDataItem] = []
    var currentRateList: [Double] = []
    var dateList: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // グラフを表示する
        setLogDataList()
        setCurrentRateData()
        setDateData()
        displayChart(data: currentRateList)
    }

    func displayChart(data: [Double]) {
        // グラフの範囲を指定する
        chartView = LineChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        // プロットデータ(y軸)を保持する配列
        var dataEntries = [ChartDataEntry]()

        for (xValue, yValue) in data.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
            dataEntries.append(dataEntry)
        }
        // グラフにデータを適用
        chartDataSet = LineChartDataSet(entries: dataEntries, label: "ポイント変動")

        chartDataSet.lineWidth = 2.0 // グラフの線の太さを変更
        chartDataSet.mode = .linear // 滑らかなグラフの曲線にする
        chartView.data = LineChartData(dataSet: chartDataSet)

        // X軸(xAxis)
        chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
        chartView.xAxis.granularity = 1.0 // X軸の表示単位を1.0ごとにする
        let formatter = DateValueFormatter(startDate: dateList.last ?? Date())
        chartView.xAxis.valueFormatter = formatter

        // Y軸(leftAxis/rightAxis)
        chartView.leftAxis.axisMaximum = (data.max() ?? 10_000) + 100 // y左軸最大値
        chartView.leftAxis.axisMinimum = (data.min() ?? 0) - 100 // y左軸最小値
        chartView.leftAxis.labelCount = 6 // y軸ラベルの数
        chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示

        // その他の変更
        chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
        chartView.legend.enabled = true // グラフ名（凡例）を非表示
        chartView.pinchZoomEnabled = false // ピンチズーム不可
        chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
        chartView.extraTopOffset = 5 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
        chartView.animate(xAxisDuration: 1.5) // 2秒かけて左から右にグラフをアニメーションで表示する

        view.addSubview(chartView)
    }

    func setLogDataList() {
        logDataList = ChartData.getLogDataList()
    }

    func setDateData() {
        logDataList.forEach {
            dateList.append($0.battleDate)
        }
    }

    func setCurrentRateData() {
        logDataList.forEach {
            currentRateList.append(Double($0.currentRate))
        }
    }
}

// struct HorizontalBarChart: UIViewRepresentable {
//    func makeUIView(context: Context) -> HorizontalBarChartView {
//        let chartView = HorizontalBarChartView()
//
//        chartView.drawBarShadowEnabled = false
//        chartView.drawValueAboveBarEnabled = true
//        chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
//        chartView.legend.enabled = true // グラフ名（凡例）を非表示
//        chartView.pinchZoomEnabled = false // ピンチズーム不可
//        chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
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
//        let logDataList: [LogDataItem] = ChartData.getLogDataList()
//        let selectedHeroNameList: [String] = []
//        let selectedHeroCountList: [Double] = [1, 2, 1]
//        chartView.data = setDataCount(selectedHeroCountList.count, val: selectedHeroCountList)
//
//        chartView.animate(yAxisDuration: 2.5)
//
//        return chartView
//    }
//
//    func updateUIView(_ uiView: HorizontalBarChartView, context: Context) {
//    }
//
//    func setDataCount(_ count: Int, val: [Double]) -> BarChartData {
//        let barWidth = 9.0
//        let spaceForBar = 10.0
//
//        let yVals = (0..<count).map { index -> BarChartDataEntry in
//            BarChartDataEntry(x: Double(index) * spaceForBar, y: val[index], icon: UIImage(systemName: "rectangle.fill"))
//        }
//
//        let set1 = BarChartDataSet(entries: yVals, label: "ヒーロー使用回数")
//        set1.drawIconsEnabled = false
//
//        let data = BarChartData(dataSet: set1)
//        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
//        data.barWidth = barWidth
//
//        return data
//    }
// }
