//
//  RealmItem.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/02.
//

import Foundation
import RealmSwift
import SwiftUI

class LogDataViewModel: ObservableObject {
    @Published var model: LogDataModel

    init(sortType: SortType = .date) {
        model = LogDataModel(sortType: sortType)
    }

    var logDataItems: Results<LogDataItem> {
        model.items
    }

    func add(heroImage: String, heroName: String, rank: Int, currentRate: Int,
             pointChange: Int, deckType: String, banType: String, screenShot: String?,
             battleDate: Date, memo: String) {
        model.add(heroImage: heroImage, heroName: heroName, rank: rank, currentRate: currentRate, pointChange: pointChange, deckType: deckType, banType: banType, screenShot: screenShot, battleDate: battleDate, memo: memo)
    }

    func delete(id: String) {
        model.delete(id: id)
    }

    func update(id: String, newItem: LogDataItem) {
        model.update(id: id, newItem: newItem)
    }
}
