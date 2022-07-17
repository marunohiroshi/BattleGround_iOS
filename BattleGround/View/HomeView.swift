//
//  ContentView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/10.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowMenuView = false
    @State private var isShowActionSheet = false
    @State private var selection = 0
    private var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: {
            if $0 == self.selection {
                // TODO: タブ押下でバトルログリストに戻るようにする
            }
            self.selection = $0
        }
    )}

    var body: some View {
        NavigationView {
            GeometryReader { _ in
                TabView(selection: handler) {
                    ZStack(alignment: .leading) {
                        // メインコンテンツ
                        VStack {
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        isShowMenuView = true
                                    }
                                }, label: {
                                    Image(systemName: "line.3.horizontal")
                                })
                                .padding()
                                Spacer()
                                Text("バトルグラウンド")
                                    .font(.title)
                                    .padding()
                                Spacer()
                                Button(action: {
                                    isShowActionSheet = true
                                }, label: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .padding()
                                .actionSheet(isPresented: $isShowActionSheet) {
                                    ActionSheet(title: Text("ログの並び順"), buttons:
                                                    [
                                                        .default(Text("順位")) {
                                                        },
                                                        .default(Text("日付")) {
                                                        },
                                                        .default(Text("お気に入り")) {
                                                        },
                                                        .cancel()
                                                    ]
                                    )
                                }
                            }
                            MainView()
                        }

                        if isShowMenuView {
                            // スライドメニューがでてきたらメインコンテンツをグレイアウトします
                            Color.gray.opacity(
                                Double(0.7)
                            )
                            MenuView(isShowMenuView: $isShowMenuView)
                                .background(Color.white)
                                .transition(.slide)
                        }
                    }

                    .tabItem {
                        Image(systemName: "note.text.badge.plus")
                        Text("ログ")
                    }
                    .tag(0)

                    ChartView()
                        .tabItem {
                            Image(systemName: "books.vertical")
                            Text("戦績")
                        }
                        .tag(0)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
    }

    // struct ContentView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        ContentView()
    //    }
    // }

}
