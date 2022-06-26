//
//  FloatButton.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/20.
//

import SwiftUI

struct FloatButton: View {
    @State private var showingModal = false
    var currentRate: Int = 0

    init(currentRate: Int) {
        self.currentRate = currentRate
    }

    var body: some View {
        Button(action: {
            self.showingModal.toggle()
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .font(.system(size: 24))
        })
        .frame(width: 60, height: 60)
        .background(Color.black)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
        .fullScreenCover(isPresented: $showingModal) {
            AddLogView(currentRate: currentRate)
        }
    }
}

// struct FloatButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FloatButton()
//    }
// }
