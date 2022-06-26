//
//  ChartData.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/25.
//

import Foundation

class ChartData {
    static var logDataList: [LogDataItem] = []

    static func getLogDataList() -> [LogDataItem] {
        logDataList
    }

    static func setLogDataList(logDataList: [LogDataItem]) {
        self.logDataList = logDataList
    }
}
