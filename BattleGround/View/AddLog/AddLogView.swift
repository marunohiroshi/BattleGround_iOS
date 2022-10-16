//
//  AddLogView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/10.
//

import SwiftUI

struct AddLogView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentation
    var viewModel = LogDataViewModel()

    @State var heroName = "test"
    @State var isShowHeroSelectView = false
    @State var rank = Int.random(in: 0..<8)
    @State var pointChange = 300
    @State var currentRate = 0
    private var currentRateFirstValue = 0
    @State var prevCurrentRate = ""
    @State var deckType = DeckType.poison
    @State var deckTypeList: [String] = []
    @State var deckTypeTitle = ""
    @State var banType = BanType.beast
    @State var banTypeList: [String] = []
    @State var banTypeTitle = ""
    @State var screenShot: UIImage?
    @State var battleDate = Date()
    @State var memo = ""
    @State private var showingModal = false
    @FocusState var focusedField: Field?
    @State var isShowPhotoLibrary = false
    @State var selectedHero = HeroData.heroDataList[Int.random(in: 0..<HeroData.heroDataList.count)]
    @State var isMoveToHome = false

    init(currentRate: Int) {
        _currentRate = State(initialValue: currentRate)
        currentRateFirstValue = currentRate
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

                                Text(self.selectedHero.heroName)
                                    .foregroundColor(Color.black)
                            }
                        })
                        Spacer()
                    }
                    .sheet(isPresented: $isShowHeroSelectView) {
                        HeroSelectView(isShowHeroSelectView: self.$isShowHeroSelectView, selectedHero: $selectedHero)
                            .environmentObject(SelectedHeroData())
                    }
                }
                Section(header: Text("順位").font(.headline)) {
                    Picker("順位", selection: $rank, content: {
                        ForEach(1..<9) {number in
                            Text(String(number))
                        }
                    })
                }

                Section(header: Text("レート変動").font(.headline)) {
                    Picker("レート変動", selection: $pointChange, content: {
                        ForEach(-300..<301) {number in
                            Text(String(number))
                        }
                    })
                    .onChange(of: pointChange, perform: {newValue in
                        currentRate = currentRateFirstValue
                        print(newValue)
                        currentRate += newValue - 300
                        if currentRate < 0 {
                            currentRate = 0
                        }
                    })
                    .pickerStyle(WheelPickerStyle())
                }

                Section(header: Text("現在のレート").font(.headline)) {
                    TextField("", text: $currentRate.changeIntToStrDef(currentRate))
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .currentRate)
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    focusedField = nil
                }

                Section(header: Text("デッキタイプ").font(.headline).navigationBarTitle("ログを追加", displayMode: .inline)
                ) {
                    NavigationLink(deckTypeTitle, destination: MultipleSelectionList(items: ["マーロック", "メカ", "獣", "悪魔", "海賊", "ドラゴン", "エレメンタル", "キルボア", "ナーガ", "毒", "混成", "断末魔", "聖なる盾", "疾風", "憤怒の織屋", "地響き使い", "ブラン", "バロン", "ノミ", "ライトスポーン"], addLogView: self, isDeckTypeSelect: true))
                }
                Section(header: Text("BAN種族").font(.headline)) {
                    NavigationLink(banTypeTitle, destination: MultipleSelectionList(items: ["マーロック", "メカ", "獣", "悪魔", "海賊", "ドラゴン", "エレメンタル", "キルボア", "ナーガ"], addLogView: self, isDeckTypeSelect: false))
                        .frame(width: .infinity, height: 50)
                }
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
                        DatePicker("", selection: $battleDate, displayedComponents: .date)
                            .frame(alignment: .leading)
                            .labelsHidden()
                        Spacer()
                    }
                }
                Section(header: Text("メモ").font(.headline)) {
                    TextField("メモ", text: $memo)
                        .focused($focusedField, equals: .memo)
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    focusedField = nil
                }
            }
            .navigationBarItems(leading: NavigationLink(destination: HomeView()
                                                            .navigationBarHidden(true)) {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            }, trailing: NavigationLink(destination: HomeView(
            )
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true), isActive: $isMoveToHome) {
                Button(action: {
                    print("onTapGesture")
                    focusedField = nil
                    isMoveToHome = true
                    let heroImage = Utility.convertImageToBase64(image: selectedHero.heroImage!)
                    let screenShot = Utility.convertImageToBase64(image: screenShot)
                    viewModel.add(heroImage: heroImage!, heroName: selectedHero.heroName, rank: rank + 1, currentRate: currentRate, pointChange: pointChange - 300, deckType: deckTypeTitle, banType: banTypeTitle, screenShot: screenShot, battleDate: battleDate, memo: memo)
                }, label: {
                    Text("追加")
                })
            }
            .onTapGesture {
                print("onTapGesture")
            }
            )
        }
    }

    func addDeckTypeList(title: String, isSelected: Bool, isDeckTypeSelect: Bool) {
        if isDeckTypeSelect {
            if !isSelected {
                deckTypeList.append(title)
            } else {
                if let index = banTypeList.firstIndex(where: {
                    $0 == title
                }) {
                    banTypeList.remove(at: index)
                }
            }
            deckTypeTitle.removeAll()

            for num in deckTypeList {
                if !deckTypeTitle.isEmpty {
                    deckTypeTitle.append("、")
                }
                deckTypeTitle.append(num)
            }
            print(deckTypeTitle)
        } else {
            if !isSelected {
                banTypeList.append(title)
            } else {
                if let index = banTypeList.firstIndex(where: {
                    $0 == title
                }) {
                    banTypeList.remove(at: index)
                }
            }
            banTypeTitle.removeAll()

            for num in banTypeList {
                if !banTypeTitle.isEmpty {
                    banTypeTitle.append("、")
                }
                banTypeTitle.append(num)
            }
            print(banTypeTitle)
        }
    }
}

struct AddLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddLogView(currentRate: 10_000)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MultipleSelectionList: View, Identifiable {
    var id = UUID()
    @State var items: [String]
    @State var selections: [String] = []
    var addLogView: AddLogView
    var isDeckTypeSelect: Bool

    var body: some View {
        List {
            ForEach(self.items, id: \.self) { item in
                MultipleSelectionRow(title: item, isSelected: selections.contains(item), addLogView: addLogView, isDeckTypeSelect: isDeckTypeSelect) {
                    if selections.contains(item) {
                        selections.removeAll(where: { $0 == item })
                    } else {
                        selections.append(item)
                    }
                }
            }
        }.onAppear {
            addLogView.deckTypeList.removeAll()
            addLogView.banTypeList.removeAll()
            addLogView.focusedField = nil
            print("onAppear")
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var addLogView: AddLogView
    var isDeckTypeSelect: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
            addLogView.addDeckTypeList(title: title, isSelected: isSelected, isDeckTypeSelect: isDeckTypeSelect)
        }) {
            HStack {
                Text(self.title).font(.subheadline)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

enum Field: Hashable {
    case currentRate
    case memo
}

extension Binding where Value == Int {
    func changeIntToStrDef(_ def: Int) -> Binding<String> {
        Binding<String>(get: {
            String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? def
        }
    }
}
