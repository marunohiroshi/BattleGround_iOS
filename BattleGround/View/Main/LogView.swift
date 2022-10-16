//
//  LogView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/14.
//

import SwiftUI

struct LogView: View, Identifiable {
    var id = UUID()
    @Binding var heroImage: String
    @Binding var heroName: String
    @Binding var rank: Int
    @Binding var currentRate: Int
    @Binding var pointChange: Int

    init(heroImage: Binding<String>, heroName: Binding<String>, rank: Binding<Int>, currentRate: Binding<Int>, pointChange: Binding<Int>) {
        _heroImage = heroImage
        _heroName = heroName
        _rank = rank
        _currentRate = currentRate
        _pointChange = pointChange
    }

    var body: some View {
        HStack {
            Image(uiImage: Utility.convertBase64ToImage(base64String: heroImage) ?? UIImage(named: "")!)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 100)
                .aspectRatio(contentMode: .fit)
                .mask {
                    Image("hero01")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 100)
                        .aspectRatio(contentMode: .fit)
                }
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(String(rank) + "位")
                        .fontWeight(.medium)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    if pointChange >= 0 {
                        Text("(+" + String(pointChange) + ")" )
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            .foregroundColor(Color.blue)
                    } else {
                        Text("(" + String(pointChange) + ")" )
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }
                .frame(alignment: .leading)
                HStack {
                    Text(heroName)
                        .fontWeight(.regular)
                        .font(.subheadline)
                    Spacer()
                }
            }
            .frame(alignment: .leading)
            Spacer()
            Text(String(currentRate))
                .font(.largeTitle)
        }
    }
}

// struct LogView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogView(heroImage: "test", heroName: "アズシャラ女王", rank: 1, currentRate: 10000, pointChange: 100)
//    }
// }
