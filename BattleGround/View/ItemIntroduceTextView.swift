//
//  ItemIntroduceTextView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct ItemIntroduceTextView: View {
    let description: String
    init(with description: String) {
        self.description = description
    }

    var body: some View {
        Text(description)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
}
