//
//  HeroSelectView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/15.
//

import SwiftUI

var roopCount: Int = 0
var selectedIndex: Int = 0

struct HeroSelectView: View {
    @Binding var isShowHeroSelectView: Bool
    @Binding var selectedHero: HeroData
    @EnvironmentObject var selectedHeroData: SelectedHeroData

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<(HeroData.heroImageList.count / 4) + 1) {verticalNumber in
                    HStack {
                        ForEach(0..<4) {horizontalNumber in
                            if roopCount < HeroData.heroImageList.count {
                                addSelectedIndex()
                                Button(action: {
                                    print(verticalNumber)
                                    print(horizontalNumber)
                                    isShowHeroSelectView.toggle()
                                    SelectedHeroData.selectedHeroData = HeroData.heroDataList[((verticalNumber + 1) * 4) - (4 - (horizontalNumber + 1)) - 1]
                                    self.selectedHero = HeroData.heroDataList[((verticalNumber + 1) * 4) - (4 - (horizontalNumber + 1)) - 1]
                                    print(HeroData.heroDataList[((verticalNumber + 1) * 4) - (4 - (horizontalNumber + 1)) - 1])
                                }, label: {
                                    HeroImage(heroImage: HeroData.heroImageList[roopCount])
                                })
                            } else {
                                Button(action: {
                                    print(verticalNumber)
                                    print(horizontalNumber)
                                }, label: {
                                    HeroImage(heroImage: HeroData.heroImageList[1])
                                })
                                .hidden()
                            }
                            addRoopCount()
                        }
                    }
                }
            }
        }
        .onDisappear {
            print("==================================")
            print("onDisappear")
            print("roopCount: " + String(roopCount))
            roopCount = 0
        }
    }
}

// struct HeroSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeroSelectView(isShowHeroSelectView: .constant(true), selectedHero: selectedHero)
//    }
// }

struct HeroImage: View, Identifiable {
    var id = UUID()
    var heroImage: UIImage?

    var body: some View {
        Image(uiImage: heroImage!)
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
    }
}

extension View {
    func addRoopCount() -> some View {
        roopCount += 1
        return EmptyView()
    }

    func addSelectedIndex() -> some View {
        selectedIndex += 1
        return EmptyView()
    }
}
