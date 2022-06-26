//
//  BattleGroundApp.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/10.
//

import SwiftUI

@main
struct BattleGroundApp: App {
    @StateObject var logDataViewModel = LogDataViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(logDataViewModel)
        }
    }
}
