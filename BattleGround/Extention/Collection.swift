//
//  Collection.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/31.
//

import Foundation

extension Collection where Element == Int {
    func sum() -> Int {
        reduce(0, +)
    }

    func average() -> Double {
        let value = sum()
        return Double(value) / Double(count)
    }
}
