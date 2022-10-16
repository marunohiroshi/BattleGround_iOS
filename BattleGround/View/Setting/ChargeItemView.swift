//
//  ChargeItemView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/23.
//

import SwiftUI

struct ChargeItemView: View {
    private let gradient = Gradient(colors: [.blue, .yellow, .red])

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Group {
                    Divider()
                    Spacer()
                    ItemView(view: AnyView(
                        ZStack {
                            LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
                                .cornerRadius(20)
                            Text("📣作者を応援する📣")
                                .foregroundColor(Color.white)
                        }
                    ), purchaseAction: purchaseAction)
                    Spacer()
                    Divider()
                }
                Spacer()
                ItemView(view: AnyView(CardView(title: "色を変更する")), purchaseAction: purchaseAction)
                Spacer()
                Divider()
                ItemView(view: AnyView(CardView(title: "リスト表示数を増やす")), purchaseAction: purchaseAction)
                Spacer()
                Divider()
            }
        }
        .background(AngularGradient(gradient: Gradient(colors: [.blue, .black, .blue]), center: .center, angle: .degrees(-45))
                        .opacity(0.2)
                        .ignoresSafeArea())
    }

    private func purchaseAction() {
    }
}

struct CardView: View {
    var title: String

    var body: some View {
        ZStack(alignment: .top) {
            Image("nature")
                .resizable()
                .frame(height: 420)
                .cornerRadius(20)
                .padding()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(radius: 4.0)
                        .padding()
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct ItemView: View {
    let view: AnyView
    let purchaseAction: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            view
            Spacer()
            VStack(alignment: .center, spacing: 0) {
                Button(action: purchaseAction) {
                    Text("¥180")
                        .bold()
                        .foregroundColor(Color.blue)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.3))
                .clipShape(Capsule())
                Text("In-app purchase")
                    .lineLimit(1)
                    .font(.caption)
            }
            .frame(alignment: .center)
            .fixedSize()
            .padding()
        }
    }
}

struct ChargeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeItemView()
    }
}
