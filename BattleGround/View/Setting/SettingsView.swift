//
//  SettingsView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/07/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentation
    @State private var isShowChargeItemView = false

    @State private var isOn = false
    @State private var pickerSelection = 0

    let languages: [String] = [
        "English",
        "Japanease",
        "French",
        "Chinese"
    ]

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Image(systemName: "person.circle")
                    Button("Sign in to your iPhone", action: {})
                }
                Section(header: Text("General")) {
                    HStack {
                        Text("Airplane Mode")
                        Spacer()
                        Toggle(isOn: $isOn) {
                            EmptyView()
                        }
                    }
                    HStack {
                        Picker(selection: $pickerSelection, label: Text("Language")) {
                            ForEach(0..<self.languages.count) { index in
                                Text(self.languages[index])
                            }
                        }
                    }
                }

                Section(header: Text("About"), footer: Text("copyright ©︎ 20XX-20XX Apple All Rights Reserved.")) {
                    HStack {
                        Text("Device Name")
                        Spacer()
                        Text(UIDevice.current.name)
                    }
                    HStack {
                        Text("Operating System")
                        Spacer()
                        Text(UIDevice.current.systemName)
                    }
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(UIDevice.current.systemVersion)
                    }
                }

                Section(header: Text("課金")) {
                    HStack {
                        ZStack {
                            Image(systemName: "xmark")
                        }
                        NavigationLink("課金アイテム一覧") {
                            ChargeItemView()
                        }
                    }
                }
            }
            .navigationBarTitle("設定")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
