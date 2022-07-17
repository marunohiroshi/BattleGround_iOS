//
//  PieChart.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/17.
//

import Charts
import SwiftUI

private var heroNameList: [String] = []
private var heroCountList: [String: Double?] = [:]

struct PieChart: UIViewRepresentable {
    init() {
        heroNameList = []
        heroCountList = [:]
    }

    func makeUIView(context: Context) -> PieChartView {
        setHeroList()

        let chartView = PieChartView()

        let legend = chartView.legend
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.xEntrySpace = 7
        legend.yEntrySpace = 0
        legend.yOffset = 0

        chartView.entryLabelColor = .black
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)

        chartView.data = setDataCount(heroNameList.count, range: 100)

        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)

        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        // no-action
    }

    func setDataCount(_ count: Int, range: UInt32) -> PieChartData {
        let entries = (0..<count).map { index -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            let findValue = heroCountList.first(where: {key, _ in
                key == heroNameList[index]
            })
            return PieChartDataEntry(value: findValue?.value ?? 1,
                                     label: heroNameList[index]
            )
        }

        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2

        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51 / 255, green: 181 / 255, blue: 229 / 255, alpha: 1)]

        let data = PieChartData(dataSet: set)

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueTextColor(.black)

        return data
    }

    func setHeroList() {
        ChartData.getLogDataList().forEach {
            heroNameList.append($0.heroName)
            let heroName = $0.heroName
            // 配列の中身の順番はランダム
            let uniqueValues = Array(Set(heroNameList))
            heroNameList = uniqueValues

            let multiHeroName = heroNameList.first(where: { $0.contains(heroName) })
            if multiHeroName == nil {
                heroCountList.updateValue(1, forKey: $0.heroName)
            } else {
                let heroCount = heroCountList.first(where: {key, _ in
                    key == multiHeroName
                })
                heroCountList.updateValue((heroCount?.value ?? 0) + 1, forKey: $0.heroName)
            }
        }
    }
}
