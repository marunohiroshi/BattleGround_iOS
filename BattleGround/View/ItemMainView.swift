//
//  ItemMainView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct ItemMainView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("nature")
                .resizable()
                .frame(height: 420)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("title")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(radius: 4.0)
                    Text("APP OF THE DAY")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .shadow(radius: 4.0)
                }
                .padding()
                Spacer()
            }
        }
    }
}
