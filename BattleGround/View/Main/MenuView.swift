//
//  MenuView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/30.
//

import SwiftUI

struct MenuView: View {
    @Binding var isShowMenuView: Bool
    @Binding private var offset: CGFloat
    @Binding private var closeOffset: CGFloat

    init(isShowMenuView: Binding<Bool>, offset: Binding<CGFloat>, closeOffset: Binding<CGFloat>) {
        _isShowMenuView = isShowMenuView
        _offset = offset
        _closeOffset = closeOffset
    }

    var body: some View {
        GeometryReader { geometry in
            //            HStack {
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
                    }
                    Text("ボブの酒場へようこそ")
                        .font(.largeTitle)
                    Divider()
                    ScrollView(.vertical, showsIndicators: true) {
                        HStack {
                            Button(action: {
                                if let url = URL(string: "https://playhearthstone.com/ja-jp/battlegrounds") {
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "safari")
                                    Text("公式サイト")
                                }
                                .padding()
                            })
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                if let url = URL(string: "https://playhearthstone.com/ja-jp/community/leaderboards?region=AP&leaderboardId=BG") {
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "safari")
                                    Text("公式ランキング")
                                }
                                .padding()
                            })
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                if let url = URL(string: "https://twitter.com/3f6N4gMYgNkfiq6") {
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                HStack {
                                    Image(systemName: "paperplane")
                                    Text("お問い合わせ")
                                }
                                .padding()
                            })
                            Spacer()
                        }
                    }
                    Divider()
                }
                .padding(.horizontal, 20)
                .frame(width: geometry.size.width * 0.7)
            }

            .onTapGesture {
                print("maruno tap")
                offset = closeOffset
            }
            //                            Rectangle()
            //                                .frame(width: geometry.size.width * 0.3, alignment: .leading)
            //                                .foregroundColor(Color.gray)
            //                                .opacity(0.3)
            //                                .onTapGesture {
            //                                    isShowMenuView = false
            //                                }
            //                        }
        }
        .padding()
    }
}

// struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
// }
