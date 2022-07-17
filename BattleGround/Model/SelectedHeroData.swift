//
//  SelectedHeroData.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/21.
//

import Foundation
import SwiftUI

class SelectedHeroData: ObservableObject {
    static var selectedHeroData = HeroData(heroName: "アズシャラ女王", heroImage: UIImage(systemName: "test"))
}
