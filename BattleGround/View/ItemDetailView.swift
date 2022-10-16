//
//  ItemDetailView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct ItemDetailView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                ItemMainView()
                InstallBanner()
                Divider()
                    .background(Color.gray)
                ItemIntroduceTextView(with: "説明文が入ります")
            }
            .background(Color("gray3"))
        }.edgesIgnoringSafeArea(.all)
    }
}
