//
//  DeckType.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/22.
//

import Foundation

enum DeckType: String, CaseIterable {
    case poison = "毒"
    case hybrid = "混成"
    case deathRattle = "断末魔"
    case devineShield = "聖なる盾"
    case windfury = "疾風"
    case groundShaker = "地響き使い"
    case brann = "ブラン"
    case baron = "バロン"
    case nomi = "ノミ"
    case khadgar = "カドガー"

    var id: String {
        self.rawValue
    }
}
