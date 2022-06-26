//
//  DateValueFormatter.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/25.
//

import Charts
import SwiftUI

class DateValueFormatter: NSObject, AxisValueFormatter {
    let dateFormatter = DateFormatter()
    var startDate: Date

    init(startDate: Date) {
        self.startDate = startDate
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: Int(value), to: startDate )!
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: modifiedDate)
    }
}
