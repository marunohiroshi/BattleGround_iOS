//
//  RecommendCollectionView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct RecommendCollectionView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            HeaderView(title: "Today")
            ItemDetailView()
                .frame(
                    width: 380,
                    height: 400,
                    alignment: .top)
                .cornerRadius(20)
            //                .disabled(true)
        }
    }
}
