//
//  LogDetailEditView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/06/19.
//

import SwiftUI

struct LogDetailEditView: View {
    @State var selectedHero: HeroData
    @Binding var logData: LogDataItem
    @Binding var isEditMode: Bool
    @State var screenShot: UIImage?

    var logDataViewModel: LogDataViewModel = .init()

    //    @Binding var heroName: String

    //    @Binding var deckType: DeckType = DeckType.poison
    //    @Binding var deckTypeList: [String] = []
    //    @Binding var deckTypeTitle =  ""
    //    @Binding var banType = BanType.beast
    //    @Binding var banTypeList: [String] = []
    //    @Binding var banTypeTitle = ""

    @State var rank: Int
    @State var currentRate: Int
    private var currentRateFirstValue = 0
    @State var pointChange: Int
    //    @Binding var battleDate: Date
    //    @Binding var memo: String

    @State var isShowHeroSelectView = false
    @State private var showingModal = false
    @State var isShowPhotoLibrary = false

    @FocusState var focusedField: Field?

    init(selectedHero: HeroData, logData: Binding<LogDataItem>, isEditMode: Binding<Bool>, screenShot: UIImage?, rank: Int, currentRate: Int, pointChange: Int) {
        _selectedHero = State(initialValue: selectedHero)
        _logData = logData
        _isEditMode = isEditMode
        _screenShot = State(initialValue: screenShot)
        _rank = State(initialValue: rank - 1)
        _currentRate = State(initialValue: currentRate)
        currentRateFirstValue = currentRate
        _pointChange = State(initialValue: pointChange + 300)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ヒーロー").font(.headline)) {
                    HStack {
                        Button(action: {
                            self.isShowHeroSelectView.toggle()
                        }, label: {
                            HStack {
                                Image(uiImage: selectedHero.heroImage!)
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
                                Text(selectedHero.heroName)
                                    .foregroundColor(Color.black)
                            }
                        })
                        Spacer()
                    }
                    .sheet(isPresented: $isShowHeroSelectView) {
                        HeroSelectView(isShowHeroSelectView: self.$isShowHeroSelectView, selectedHero:
                                        $selectedHero)
                            .environmentObject(SelectedHeroData())
                    }
                }
                Section(header: Text("順位").font(.headline)) {
                    Picker("順位", selection: $rank, content: {
                        ForEach(1..<9) {n in
                            Text(String(n))
                        }
                    })
                }

                Section(header: Text("レート変動").font(.headline)) {
                    Picker("レート変動", selection: $pointChange, content: {
                        ForEach(-300..<301) {n in
                            Text(String(n))
                        }
                    })
                    .onChange(of: pointChange, perform: {newValue in
                        currentRate = currentRateFirstValue
                        print("currentRateFirstValue: \(currentRateFirstValue)")
                        print("newValue: \(newValue)")
                        if currentRate < 300 {
                            currentRate = newValue - 300
                        } else {
                            currentRate = currentRateFirstValue - (600 - newValue)
                        }
                        if currentRate < 0 {
                            currentRate = 0
                        }
                    })
                    .pickerStyle(WheelPickerStyle())
                }

                Section(header: Text("現在のレート").font(.headline)) {
                    TextField("", text: $currentRate.IntToStrDef(
                                currentRate))
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .currentRate)
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    focusedField = nil
                }

                //                    Section(header: Text("デッキタイプ").font(.headline)) {
                //                        NavigationLink(deckTypeTitle, destination: MultipleSelectionList(items: ["マーロック","メカ","獣","悪魔","海賊","ドラゴン","エレメンタル","キルボア","ナーガ","毒","混成","断末魔","聖なる盾","疾風","憤怒の織屋","地響き使い","ブラン","バロン","ノミ","ライトスポーン"], addLogView: self, isDeckTypeSelect: true))
                //                    }
                //                    Section(header: Text("BAN種族").font(.headline)) {
                //                        NavigationLink(banTypeTitle, destination: MultipleSelectionList(items: ["マーロック","メカ","獣","悪魔","海賊","ドラゴン","エレメンタル","キルボア","ナーガ"], addLogView: self, isDeckTypeSelect: false))
                //                            .frame(width: .infinity, height: 50)
                //                    }
                Section(header: Text("スクリーンショット").font(.headline)) {
                    ZStack {
                        if screenShot == nil {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: .infinity, height: 100)
                            Button(action: {
                                isShowPhotoLibrary = true
                            }, label: {
                                Image(systemName: "camera")
                            })
                            .frame(width: 100, height: 100)
                            .sheet(isPresented: $isShowPhotoLibrary) {
                                PHPickerView(isShowSheet: $isShowPhotoLibrary, screenShot: $screenShot)
                            }
                        } else {
                            Button(action: {
                                isShowPhotoLibrary = true
                            }, label: {
                                Image(uiImage: screenShot ?? UIImage(named: "")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            })
                            .sheet(isPresented: $isShowPhotoLibrary) {
                                PHPickerView(isShowSheet: $isShowPhotoLibrary, screenShot: $screenShot)
                            }
                        }
                    }
                }
                Section(header: Text("対戦日").font(.headline)) {
                    HStack {
                        DatePicker("", selection: $logData.battleDate, displayedComponents: .date)
                            .frame(alignment: .leading)
                            .labelsHidden()
                        Spacer()
                    }
                }
                Section(header: Text("メモ").font(.headline)) {
                    TextField("メモ", text: $logData.memo)
                        .focused($focusedField, equals: .memo)
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    focusedField = nil
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        isEditMode = false
                    }, label: {
                        Text("キャンセル")
                    }
                )
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditMode = false
                    let newItem = LogDataItem()
                    let heroImage = Utility.convertImageToBase64(image: selectedHero.heroImage!)
                    let screenShot = Utility.convertImageToBase64(image: screenShot)
                    let rank = rank + 1
                    newItem.id = logData.id
                    newItem.heroImage = heroImage!
                    newItem.heroName = selectedHero.heroName
                    newItem.rank = rank
                    newItem.currentRate = currentRate
                    newItem.pointChange = pointChange - 300
                    newItem.screenShot = screenShot ?? ""
                    newItem.battleDate = logData.battleDate
                    newItem.memo = logData.memo
                    logData = newItem
                    logDataViewModel.update(id: newItem.id, newItem: newItem)
                }) {
                    Text("保存")
                }
            }
        }
    }

    //    func addDeckTypeList(title: String, isSelected: Bool, isDeckTypeSelect: Bool) {
    //        if isDeckTypeSelect {
    //            if !isSelected {
    //                deckTypeList.append(title)
    //            } else {
    //                if let index = banTypeList.firstIndex(where: {
    //                    $0 == title
    //                }) {
    //                    banTypeList.remove(at: index)
    //                }
    //            }
    //            deckTypeTitle.removeAll()
    //
    //            for num in deckTypeList {
    //                if !deckTypeTitle.isEmpty {
    //                    deckTypeTitle.append("、")
    //                }
    //                deckTypeTitle.append(num)
    //            }
    //            print(deckTypeTitle)
    //        } else {
    //            if !isSelected {
    //                banTypeList.append(title)
    //            } else {
    //                if let index = banTypeList.firstIndex(where: {
    //                    $0 == title
    //                }) {
    //                    banTypeList.remove(at: index)
    //                }
    //            }
    //            banTypeTitle.removeAll()
    //
    //            for num in banTypeList {
    //                if !banTypeTitle.isEmpty {
    //                    banTypeTitle.append("、")
    //                }
    //                banTypeTitle.append(num)
    //            }
    //            print(banTypeTitle)
    //        }
    //    }
}
