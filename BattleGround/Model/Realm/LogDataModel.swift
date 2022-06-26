//
//  RealmItemDB.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/02.
//

import RealmSwift
import Realm
import Foundation
// Realm用のClass
class LogDataModel: ObservableObject {
    var config: Realm.Configuration

    init() {
        config = Realm.Configuration()
    }

    var realm: Realm {
        try! Realm(configuration: config)
    }

    var items: Results<LogDataItem> {
        realm.objects(LogDataItem.self)
        //            .sorted(byKeyPath: "battleDate")
    }

    func add(heroImage: String, heroName: String, rank: Int, currentRate: Int,
             pointChange: Int, deckType: String, banType: String, screenShot: String?,
             battleDate: Date, memo: String) {
        do {
            objectWillChange.send()

            let item = LogDataItem()
            //            let id = (items.sorted(byKeyPath: "id").last?.id ?? "0")
            item.id = UUID().uuidString
            item.heroImage = heroImage
            item.heroName = heroName
            item.rank = rank
            item.currentRate = currentRate
            item.pointChange = pointChange
            item.deckType = deckType
            item.banType = banType
            item.screenShot = screenShot ?? ""
            item.battleDate = battleDate
            item.memo = memo

            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func delete(id: String) {
        objectWillChange.send()
        let realm = try! Realm()
        guard let LogDataItem = items.first(where: { $0.id == id }) else {
            return
        }
        do {
            try realm.write {
                realm.delete(LogDataItem)
                ChartData.setLogDataList(logDataList: Array(items))
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func update(id: String, newItem: LogDataItem) {
        objectWillChange.send()
        guard let LogDataItem = items.first(where: { $0.id == id }) else {
            return
        }
        do {
            try realm.write {
                LogDataItem.heroImage = newItem.heroImage
                LogDataItem.heroName = newItem.heroName
                LogDataItem.currentRate = newItem.currentRate
                LogDataItem.rank = newItem.rank
                LogDataItem.pointChange = newItem.pointChange
                LogDataItem.screenShot = newItem.screenShot
                LogDataItem.battleDate = newItem.battleDate
                LogDataItem.memo = newItem.memo
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}

class LogDataItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var heroImage: String
    @Persisted var heroName: String
    @Persisted var rank: Int
    @Persisted var currentRate: Int
    @Persisted var pointChange: Int
    @Persisted var deckType: String
    @Persisted var banType: String
    @Persisted var screenShot: String
    @Persisted var battleDate: Date
    @Persisted var memo: String
}
