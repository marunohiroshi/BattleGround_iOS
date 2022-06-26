//
//  AddLogView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/10.
//

import SwiftUI

struct LogDetailView: View {
    @Environment(\.presentationMode) var presentation
    @GestureState private var dragOffset: CGSize = .zero
    private let edgeWidth: CGFloat = 50
    private let baseDragWidth: CGFloat = 30

    @Binding var logData: LogDataItem
    @Binding var isShowingFloatButton: Bool

    @State var isEditMode = false

    init(logData: Binding<LogDataItem>, isShowingFloatButton: Binding<Bool>) {
        _logData = logData
        self._isShowingFloatButton = isShowingFloatButton
        //        _selectedHero = State(initialValue: HeroData(heroName: logData.heroName, heroImage: Utility.convertBase64ToImage(base64String: logData.heroImage) ?? UIImage(systemName: "camera")!))
    }

    var body: some View {
        if !isEditMode {
            Form {
                if logData.screenShot != "" {
                    Section(header: Text("スクリーンショット").font(.headline)) {
                        Image(uiImage: Utility.convertBase64ToImage(base64String: logData.screenShot) ?? UIImage(systemName: "camera")!)
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                    }
                }

                Section(header: Text("ヒーロー").font(.headline)) {
                    HStack {
                        Image(uiImage: Utility.convertBase64ToImage(base64String: logData.heroImage) ?? UIImage(named: "")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 70)
                            .aspectRatio(contentMode: .fit)
                            .mask {
                                Image("hero01")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 70)
                                    .aspectRatio(contentMode: .fit)
                            }
                        Text(logData.heroName)
                            .foregroundColor(Color.black)
                    }
                }
                Section(header: Text("順位").font(.headline)) {
                    Text(String(logData.rank))
                }

                Section(header: Text("レート変動").font(.headline)) {
                    if logData.pointChange > 0 {
                        Text("+\(String(logData.pointChange))")
                    } else {
                        Text(String(logData.pointChange))
                    }
                }

                Section(header: Text("現在のレート").font(.headline)) {
                    Text(String(logData.currentRate))
                }

                Section(header: Text("デッキタイプ").font(.headline)) {
                    Text(logData.deckType)
                }

                Section(header: Text("BAN種族").font(.headline)) {
                    Text(logData.banType)
                }

                Section(header: Text("対戦日").font(.headline)) {
                    Text(DateUtils.stringFromDate(date: logData.battleDate, format: "yyyy年MM月dd日"))
                }
                Section(header: Text("メモ").font(.headline)) {
                    Text(logData.memo)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            isShowingFloatButton = true
                            self.presentation.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("バトルログ")
                            }
                        }
                    )
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditMode = true
                        //                        initData()
                    }) {
                        Text("編集")
                    }
                }
            }
            .highPriorityGesture(
                DragGesture().updating(
                    $dragOffset, body: { value, _, _ in
                        if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth {
                            isShowingFloatButton = true
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                )
            )
        } else {// 編集モード
            LogDetailEditView(
                selectedHero: HeroData(heroName: logData.heroName, heroImage: Utility.convertBase64ToImage(base64String: logData.heroImage) ?? UIImage(named: "")!),
                logData: $logData,
                isEditMode: $isEditMode,
                screenShot: Utility.convertBase64ToImage(base64String: logData.screenShot),
                rank: logData.rank,
                currentRate: logData.currentRate,
                pointChange: logData.pointChange
            )
        }
    }

}
