//
//  TestView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/31.
//

import SwiftUI

struct DataItem: Identifiable {
    let name: String
    let values: [Double]
    let id = UUID()
}

struct BarChartData {
    let keys: [String]
    let data: [DataItem]
}

// Use colors from MatPlotLib ListedColormap (matplotlib.pyplot.cm.tab10)
private var colors: [Color] =
    [
        Color(red: 0.122, green: 0.467, blue: 0.706),  // #1f77b4
        Color(red: 1.000, green: 0.498, blue: 0.055),  // #ff7f0e
        Color(red: 0.173, green: 0.627, blue: 0.173),  // #2ca02c
        Color(red: 0.839, green: 0.153, blue: 0.157),  // #d62728
        Color(red: 0.580, green: 0.404, blue: 0.741),  // #9467bd
        Color(red: 0.549, green: 0.337, blue: 0.294),  // #8c564b
        Color(red: 0.890, green: 0.467, blue: 0.761),  // #e377c2
        Color(red: 0.498, green: 0.498, blue: 0.498),  // #7f7f7f
        Color(red: 0.737, green: 0.741, blue: 0.133),  // #bcbd22
        Color(red: 0.090, green: 0.745, blue: 0.812)   // #17becf
    ]

struct ChartColors {
    static func barColor(_ colorIndex: Int) -> Color {
        colors[colorIndex % colors.count]
    }
}

struct TestView: View {
    @State private var isShowingYAxis = true
    @State private var isShowingXAxis = true
    @State private var isShowingHeading = true
    @State private var isShowingKey = true

    @State private var isHShowingYAxis = true
    @State private var isHShowingXAxis = true
    @State private var isHShowingHeading = true
    @State private var isHShowingKey = true

    var logDataList: [LogDataItem] = ChartData.getLogDataList()

    let chartData = BarChartData(
        keys: ["使用回数"],
        data: [
            DataItem(name: "Somalia", values: [127]),
            DataItem(name: "Nigeria", values: [127]),
            DataItem(name: "Chad", values: [125]),
            DataItem(name: "Central African Republic", values: [123]),
            DataItem(name: "Sierra Leone", values: [111])
        ])

    //    private func getDataItem() -> [DataItem] {
    //        var dataItemList: [DataItem] = []
    //        var deckTypeArray: [String] = ["マーロック", "メカ", "獣", "悪魔", "海賊", "ドラゴン", "エレメンタル", "キルボア", "ナーガ", "毒", "混成", "断末魔", "聖なる盾", "疾風", "憤怒の織屋", "地響き使い", "ブラン", "バロン", "ノミ", "ライトスポーン"]
    //        var deckTypeNameList: [String] = []
    //        var deckTypeUseCountList: [Double] = []
    //        logDataList.forEach { logdata in
    //            dataItemList.append(DataItem(name: logdata., values: <#T##[Double]#>))
    //        }
    //    }

    var body: some View {
        ScrollView {
            VStack {
                //                VStack {
                //                    Spacer()
                //                        .frame(height: 20)
                //
                //                    BarChartView(
                //                        title: "Under 5 Mortality Rate by Gender [2018]",
                //                        chartData: chartData,
                //                        isShowingYAxis: isShowingYAxis,
                //                        isShowingXAxis: isShowingXAxis,
                //                        isShowingHeading: isShowingHeading,
                //                        isShowingKey: isShowingKey)
                //                        .animation(.default)
                //                        .frame(width: 400, height: 450, alignment: .center)
                //
                //                    Spacer()
                //                        .frame(height: 50)
                //
                //                    VStack {
                //                        Text("Chart Settings")
                //                            .font(.title2)
                //                        Toggle("Show Y axis", isOn: $isShowingYAxis)
                //                        Toggle("Show X axis", isOn: $isShowingXAxis)
                //                        Toggle("Show heading", isOn: $isShowingHeading)
                //                        Toggle("Show Key", isOn: $isShowingKey)
                //                    }
                //                    .padding(.horizontal, 50)
                //
                //                    Spacer()
                //                }

                VStack {
                    BarChartHView(
                        title: "",
                        chartData: chartData,
                        isShowingYAxis: isHShowingYAxis,
                        isShowingXAxis: isHShowingXAxis,
                        isShowingHeading: isHShowingHeading,
                        isShowingKey: isHShowingKey)
                        .animation(.default)
                        .frame(width: 400, height: 450, alignment: .center)

                    //                    VStack {
                    //                        Text("Chart Settings")
                    //                            .font(.title2)
                    //                        Toggle("Show Y axis", isOn: $isHShowingYAxis)
                    //                        Toggle("Show X axis", isOn: $isHShowingXAxis)
                    //                        Toggle("Show heading", isOn: $isHShowingHeading)
                    //                        Toggle("Show Key", isOn: $isHShowingKey)
                    //                    }
                    //                    .padding(.horizontal, 50)

                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct AxisParameters {
    static func getTicks(top: Int) -> [Int] {
        var step = 0
        var high = top
        switch top {
        case 0...8:
            step = 1

        case 9...17:
            step = 2

        case 18...50:
            step = 5

        case 51...170:
            step = 10

        case 171...500:
            step = 50

        case 501...1_700:
            step = 200

        case 1_701...5_000:
            step = 500

        case 5_001...17_000:
            step = 1_000

        case 17_001...50_000:
            step = 5_000

        case 50_001...170_000:
            step = 10_000

        case 170_001...1_000_000:
            step = 10_000

        default:
            step = 10_000
        }
        high = ((top / step) * step) + step + step
        var ticks: [Int] = []
        for index in stride(from: 0, to: high, by: step) {
            ticks.append(index)
        }
        return ticks
    }
}

struct BarChartView: View {
    var title: String
    var chartData: BarChartData
    var isShowingYAxis = true
    var isShowingXAxis = true
    var isShowingHeading = true
    var isShowingKey = true

    var body: some View {
        let data = chartData.data
        GeometryReader { gr in
            let axisWidth = gr.size.width * (isShowingYAxis ? 0.15 : 0.0)
            let axisHeight = gr.size.height * (isShowingXAxis ? 0.1 : 0.0)
            let keyHeight = gr.size.height * (isShowingKey ? 0.1 : 0.0)
            let headHeight = gr.size.height * (isShowingHeading ? 0.14 : 0.0)
            let fullChartHeight = gr.size.height - axisHeight - headHeight - keyHeight

            let maxValue = data.flatMap { $0.values }.max()!
            let tickMarks = AxisParameters.getTicks(top: Int(maxValue))
            let scaleFactor = (fullChartHeight * 0.95) / CGFloat(tickMarks[tickMarks.count - 1])

            VStack(spacing: 0) {
                if isShowingHeading {
                    ChartHeaderView(title: title)
                        .frame(height: headHeight)
                }
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

                    VStack(spacing: 0) {
                        if isShowingKey {
                            KeyView(keys: chartData.keys)
                                .frame(height: keyHeight)
                        }

                        HStack(spacing: 0) {
                            if isShowingYAxis {
                                YaxisView(ticks: tickMarks, scaleFactor: Double(scaleFactor))
                                    .frame(width: axisWidth, height: fullChartHeight)
                            }
                            ChartAreaView(data: data, scaleFactor: Double(scaleFactor))
                                .frame(height: fullChartHeight)
                        }
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: axisWidth, height: axisHeight)
                            if isShowingXAxis {
                                XaxisView(data: data)
                                    .frame(height: axisHeight)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ChartHeaderView: View {
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct ChartAreaView: View {
    var data: [DataItem]
    var scaleFactor: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

            VStack {
                HStack(spacing: 0) {
                    ForEach(data) { item in
                        BarView(
                            name: item.name,
                            values: item.values,
                            scaleFactor: scaleFactor)
                    }
                }
            }
        }
    }
}

struct BarView: View {
    var name: String
    var values: [Double]
    var scaleFactor: Double

    var body: some View {
        GeometryReader { gr in
            let textWidth = gr.size.width * 0.80
            let padWidth = gr.size.width * 0.07
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: padWidth)

                ForEach(values.indices) { index in
                    let barHeight = values[index] * scaleFactor

                    ZStack {
                        VStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .fill(ChartColors.barColor(index))
                                .frame(height: min(5.0, CGFloat(barHeight)), alignment: .trailing)
                        }

                        VStack(spacing: 0) {
                            Spacer()
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(ChartColors.barColor(index))
                                .frame(height: CGFloat(barHeight), alignment: .trailing)
                                .overlay(
                                    Text("\(values[index], specifier: "%.0F")")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .frame(width: textWidth)
                                        .rotationEffect(Angle(degrees: -90))
                                        .offset(y: 15)
                                    ,
                                    alignment: .top
                                )
                        }
                    }
                }

                Spacer()
                    .frame(width: padWidth)
            }
        }
    }
}

struct YaxisView: View {
    var ticks: [Int]
    var scaleFactor: Double

    var body: some View {
        GeometryReader { gr in
            let fullChartHeight = gr.size.height
            ZStack {
                // y-axis line
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1.5)
                    .offset(x: (gr.size.width / 2.0) - 1, y: 1)

                // Tick marks
                ForEach(ticks, id: \.self) { tick in
                    HStack {
                        Spacer()
                        Text("\(tick)")
                            .font(.footnote)
                        Rectangle()
                            .frame(width: 10, height: 1)
                    }
                    .offset(y: (fullChartHeight / 2.0) - (CGFloat(tick) * CGFloat(scaleFactor)))
                }
            }
        }
    }
}

struct XaxisView: View {
    var data: [DataItem]

    var body: some View {
        GeometryReader { gr in
            let labelWidth = (gr.size.width * 0.9) / CGFloat(data.count)
            let padWidth = (gr.size.width * 0.05) / CGFloat(data.count)
            ZStack {
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1.5)
                    .offset(x: 0, y: -(gr.size.height / 2.0))

                HStack(spacing: 0) {
                    ForEach(data) { item in
                        Text(item.name)
                            .font(.footnote)
                            .frame(width: labelWidth, height: gr.size.height)
                    }
                    .padding(.horizontal, padWidth)
                }
            }
        }
    }
}

struct KeyView: View {
    let keys: [String]

    var body: some View {
        HStack {
            ForEach(keys.indices) { index in
                HStack(spacing: 0) {
                    Image(systemName: "square.fill")
                        .foregroundColor(ChartColors.barColor(index))

                    Text("\(keys[index])")
                }
                .font(.footnote)
            }
        }
    }
}

// Horizontal SwiftUI Views
struct BarChartHView: View {
    var title: String
    var chartData: BarChartData
    var isShowingYAxis = true
    var isShowingXAxis = true
    var isShowingHeading = true
    var isShowingKey = true

    var body: some View {
        let data = chartData.data
        GeometryReader { gr in
            let axisWidth = gr.size.width * (isShowingYAxis ? 0.15 : 0.0)
            let axisHeight = gr.size.height * (isShowingXAxis ? 0.1 : 0.0)
            let keyHeight = gr.size.height * (isShowingKey ? 0.1 : 0.0)
            let headHeight = gr.size.height * (isShowingHeading ? 0.14 : 0.0)
            let fullChartHeight = gr.size.height - axisHeight - headHeight - keyHeight
            let fullChartWidth = gr.size.width - axisWidth

            let maxValue = data.flatMap { $0.values }.max()!
            let tickMarks = AxisParameters.getTicks(top: Int(maxValue))
            let scaleFactor = (fullChartWidth * 0.95) / CGFloat(tickMarks[tickMarks.count - 1])

            VStack(spacing: 0) {
                if isShowingHeading {
                    ChartHeaderView(title: title)
                        .frame(height: headHeight)
                }
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

                    VStack(spacing: 0) {
                        if isShowingKey {
                            KeyView(keys: chartData.keys)
                                .frame(height: keyHeight)
                        }

                        HStack(spacing: 0) {
                            if isShowingYAxis {
                                YaxisHView(data: data)
                                    .frame(width: axisWidth, height: fullChartHeight)
                            }
                            ChartAreaHView(data: data, scaleFactor: Double(scaleFactor))
                                .frame(height: fullChartHeight)
                        }
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: axisWidth, height: axisHeight)
                            if isShowingXAxis {
                                XaxisHView(ticks: tickMarks, scaleFactor: Double(scaleFactor))
                                    .frame(height: axisHeight)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ChartAreaHView: View {
    var data: [DataItem]
    var scaleFactor: Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

            VStack {
                VStack(spacing: 0) {
                    ForEach(data) { item in
                        BarHView(
                            name: item.name,
                            values: item.values,
                            scaleFactor: scaleFactor)
                    }
                }
            }
        }
    }
}

struct BarHView: View {
    var name: String
    var values: [Double]
    var scaleFactor: Double

    var body: some View {
        GeometryReader { gr in
            let padHeight = gr.size.height * 0.07
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: padHeight)

                ForEach(values.indices) { index in
                    let barSize = values[index] * scaleFactor

                    ZStack {
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(ChartColors.barColor(index))
                                .frame(width: min(5.0, CGFloat(barSize)), alignment: .trailing)
                            Spacer()
                        }

                        HStack(spacing: 0) {
                            RoundedRectangle(cornerRadius: 5.0)
                                .fill(ChartColors.barColor(index))
                                .frame(width: CGFloat(barSize), alignment: .trailing)
                                .overlay(
                                    Text("\(values[index], specifier: "%.0F")")
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .offset(x: -10, y: 0)
                                    ,
                                    alignment: .trailing
                                )
                            Spacer()
                        }
                    }
                }

                Spacer()
                    .frame(height: padHeight)
            }
        }
    }
}

struct XaxisHView: View {
    var ticks: [Int]
    var scaleFactor: Double

    var body: some View {
        GeometryReader { gr in
            let fullChartWidth = gr.size.width
            ZStack {
                // x-axis line
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1.5)
                    .offset(x: 0, y: -(gr.size.height / 2.0))

                // Tick marks
                ForEach(ticks, id: \.self) { tick in
                    VStack {
                        Rectangle()
                            .frame(width: 1, height: 10)
                        Text("\(tick)")
                            .font(.footnote)
                            .rotationEffect(Angle(degrees: -45))
                        Spacer()
                    }
                    .offset(x: (CGFloat(tick) * CGFloat(scaleFactor)) - (fullChartWidth / 2.0) - 1)
                }
            }
        }
    }
}

struct YaxisHView: View {
    var data: [DataItem]

    var body: some View {
        GeometryReader { gr in
            let labelHeight = (gr.size.height * 0.9) / CGFloat(data.count)
            let padHeight = gr.size.height * 0.05 / CGFloat(data.count)

            ZStack {
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.8906477705, green: 0.9005050659, blue: 0.8208766097, alpha: 1)))

                // y-axis line
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1.5)
                    .offset(x: (gr.size.width / 2.0) - 1, y: 1)

                VStack(spacing: 0) {
                    ForEach(data) { item in
                        Text(item.name)
                            .font(.footnote)
                            .frame(height: labelHeight)
                    }
                    .padding(.vertical, padHeight)
                }
            }
        }
    }
}
