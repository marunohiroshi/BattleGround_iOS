//
//  HeaderView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    init(title: String) {
        self.title = title
    }

    var body: some View {
        VStack {
            HStack {
                Text("12月22日 日曜日")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(16)
                Spacer()
            }.frame(height: 16, alignment: .topLeading)
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(16)
                Spacer()
                Image("bob")
                    .resizable() // 画像のサイズを変更可能にする
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36, height: 36, alignment: .center)
                    .clipShape(Circle()) // 正円形に切り抜く
                    .padding(.trailing, 16)
            }
        }
    }
}
