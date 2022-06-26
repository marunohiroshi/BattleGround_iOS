//
//  MenuView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/30.
//

import SwiftUI

struct MenuView: View {
    @Binding var isShowMenuView: Bool

    init(isShowMenuView: Binding<Bool>) {
        _isShowMenuView = isShowMenuView
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Group {
                    VStack(alignment: .leading) {
                        HStack {
                            Image("bob")
                                .resizable()
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 1))
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            Spacer()
                            //                            Button(action: {
                            //                                isShowMenuView = false
                            //                            }, label: {
                            //                                VStack {
                            //                                    Image(systemName: "arrowshape.turn.up.right")
                            //                                    Text("戻る")
                            //                                }
                            //                            })
                        }
                        Text("ボブの酒場へようこそ")
                            .font(.largeTitle)
                        Divider()
                        ScrollView(.vertical, showsIndicators: true) {
                            HStack {
                                Image(systemName: "person")
                                Text("Profile")
                            }
                            .padding()
                            HStack {
                                Image(systemName: "list.dash")
                                Text("Lists")
                            }
                            .padding()
                            HStack {
                                Image(systemName: "text.bubble")
                                Text("Topics")
                            }
                            .padding()
                        }
                        Divider()
                        Text("Settings and privacy")
                    }
                    .padding(.horizontal, 20)
                    .frame(width: geometry.size.width * 0.7)
                }
                Rectangle()
                    .frame(width: geometry.size.width * 0.3, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .onTapGesture {
                        isShowMenuView = false
                    }
            }
        }
    }
}

// struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
// }
