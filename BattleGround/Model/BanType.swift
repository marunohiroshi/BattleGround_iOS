//
//  BanType.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/22.
//

import Foundation

public enum BanType: String, CaseIterable {
    case murloc = "マーロック"
    case mech = "メカ"
    case beast = "獣"
    case demon  = "悪魔"
    case pirate = "海賊"
    case dragon = "ドラゴン"
    case elemental = "エレメンタル"
    case quilboar = "キルボア"
    case naga = "ナーガ"

    public var id: String {
        self.rawValue
    }
}
