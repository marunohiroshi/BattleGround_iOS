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
    @State private var isForceShowTopView = false
    @State private var logDataViewModel = LogDataViewModel()
    @State private var isShowSetting = false

    private var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: {
            if $0 == self.selection {
                if selection == 0 {
                    // TODO: タブ押下でバトルログリストに戻るようにする
                    isForceShowTopView.toggle()
                }
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
                                    Image(systemName: "gearshape")
                                })
                                .fullScreenCover(isPresented: $isShowMenuView) {
                                    SettingsView()
                                }
                                .padding()
                                Text("バトルグラウンド")
                                    .frame(alignment: .center)
                                    .font(.title)
                                    .padding()
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
                                                            logDataViewModel = LogDataViewModel(sortType: .rank)
                                                        },
                                                        .default(Text("日付")) {
                                                            logDataViewModel = LogDataViewModel(sortType: .date)
                                                        },
                                                        .default(Text("お気に入り")) {
                                                            // no-action
                                                        },
                                                        .cancel()
                                                    ]
                                    )
                                }
                            }

                            MainView(logDataViewModel: logDataViewModel)
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
                        .tag(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
    }
}
