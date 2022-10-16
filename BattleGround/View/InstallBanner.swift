//
//  InstallBanner.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/18.
//

import SwiftUI

struct InstallBanner: View {
    var body: some View {
        HStack {
            Image("rainbow")
                .resizable()
                .frame(width: 48, height: 48)
                .padding()
            VStack(alignment: .leading) {
                Text("WeatherApp")
                    .font(.headline)
                    .lineLimit(1)
                Text("Deliver the weather forecast")
                    .font(.footnote)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Button(action: {
                    //
                }) {
                    Text("GET")
                        .bold()
                        .foregroundColor(Color.blue)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(Color.white)
                .clipShape(Capsule())
                Text("In-app purchase")
                    .lineLimit(1)
                    .font(.caption)
            }
            .fixedSize()
            .padding()
        }
        .foregroundColor(Color.white)
        .background(Color("gray3"))
    }
}
