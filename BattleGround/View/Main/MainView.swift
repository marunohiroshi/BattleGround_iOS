//
//  MainView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/20.
//

import RealmSwift
import SwiftUI

struct MainView: View {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var logDataViewModel: LogDataViewModel

    @State var logDataList: [LogDataItem] = []
    @State var isShowingFloatButton = true
    @State var heroImage = Image("hero01")

    var body: some View {
        VStack {
            if logDataViewModel.logDataItems.isEmpty {
                VStack(alignment: .center) {
                    Text("右下の+ボタンからログを追加しよう")
                }
            }
            ZStack(alignment: .bottomTrailing) {
                NavigationView {
                    Form {
                        Section {
                            List {
                                ForEach($logDataList, id: \.id) { $item in
                                    if !item.isInvalidated {
                                        NavigationLink(destination: LogDetailView(logData: $item, isShowingFloatButton: $isShowingFloatButton).onAppear {
                                            isShowingFloatButton = false
                                        }) {
                                            LogView(
                                                heroImage: $item.heroImage,
                                                heroName: $item.heroName,
                                                rank: $item.rank,
                                                currentRate: $item.currentRate,
                                                pointChange: $item.pointChange)
                                        }
                                    }
                                }
                                .onDelete { indexSet in
                                    if logDataViewModel.model.sortType == .date {
                                        removeDateRow(indexSet: indexSet)
                                    } else {
                                        removeRankRow(indexSet: indexSet)
                                    }
                                }
                            }
                            .navigationBarTitle("バトルログ")
                            .navigationBarTitleDisplayMode(.large)
                        }
                    }
                    .toolbar {
                        if !logDataViewModel.logDataItems.isEmpty {
                            EditButton()
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)

                if isShowingFloatButton {
                    FloatButton(currentRate: logDataList.first?.currentRate ?? 0)
                }
            }
        }
        .onReceive(logDataViewModel.$model) {_ in
            reloadData()
        }
        .onAppear {
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            reloadData()
        }
    }

    func removeDateRow(indexSet: IndexSet) {
        logDataList.remove(atOffsets: indexSet)
        guard let index = indexSet.first else {
            return
        }
        let count = logDataViewModel.logDataItems.count - index - 1
        // 削除する行のIDを取得
        let deleteId = logDataViewModel.logDataItems[count].id
        // 行を削除する
        logDataViewModel.delete(id: deleteId)
        reloadData()
    }

    func removeRankRow(indexSet: IndexSet) {
        logDataList.remove(atOffsets: indexSet)
        guard let index = indexSet.first else {
            return
        }
        // 削除する行のIDを取得
        let deleteId = logDataViewModel.logDataItems[index].id
        // 行を削除する
        logDataViewModel.delete(id: deleteId)
    }

    func replaceRow(_ from: IndexSet, _ to: Int) {
        //        LogData.logDataList.move(fromOffsets: from, toOffset: to)
        //        logDataList.move(fromOffsets: from, toOffset: to)
    }

    func reloadData() {
        if logDataViewModel.model.sortType == .date {
            logDataList = Array(logDataViewModel.logDataItems).reversed()
        } else {
            logDataList = Array(logDataViewModel.logDataItems)
        }
        logDataList.forEach {item in
            logDataViewModel.update(id: item.id, newItem: item)
        }
        ChartData.setLogDataList(logDataList: Array(logDataViewModel.logDataItems))
    }
}

// struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
// }
