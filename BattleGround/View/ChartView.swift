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
                Text("ポイント変動")
                if isShowChart {
                    ChartViewControllerWrapper()
                }
            }
        }.navigationBarTitle("") // this must be empty
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
        //        chartView.xAxis.granularity = 1.0 //X軸の表示単位を1.0ごとにする
        let formatter = DateValueFormatter(startDate: dateList.first ?? Date())
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

// struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
// }
