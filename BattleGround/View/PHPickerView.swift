//
//  PHPickerView.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/15.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    @Binding var isShowSheet: Bool
    @Binding var screenShot: UIImage?
    //    @Binding var screenShot: Image

    // Coordinatorでコントローラのdelegateを管理
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        // PHPickerView型の変数を用意
        var parent: PHPickerView

        init(parent: PHPickerView) {
            self.parent = parent
        }

        // フォトライブラリで写真を選択、キャンセルしたときに実行される
        // delegateメソッドを必ず用意
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

            // 写真は一つだけ選べる設定なので最初の一件を指定
            if let result = results.first {
                // 写真の取得は非同期で実施
                // 取得ができたらクロージャーが動く
                result.itemProvider.loadObject(ofClass: UIImage.self) {
                    image, _ in
                    // 写真が選択できたら
                    if let unwrapImage = image as? UIImage {
                        // 選択された写真を追加する
                        self.parent.screenShot = unwrapImage
                        if let unwrapImage = self.parent.screenShot {
                            //                            self.parent.screenShot = Image(uiImage: unwrapImage)
                        }
                    } else {
                        print("使用できる写真がありません")
                    }
                }
            } else {
                print("選択された写真はありません")
            }

            parent.isShowSheet = false
        }
    }

    // Coorinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        // Coordinatorクラスのインスタンスを生成
        Coordinator(parent: self)
    }

    // Viewを生成する時に実行
    func makeUIViewController(context: UIViewControllerRepresentableContext<PHPickerView>) -> PHPickerViewController {
        // PHPickerViewControllerのカスタマイズ
        var configuration = PHPickerConfiguration()
        // 静止画を選択
        configuration.filter = .images
        // フォトライブラリで選択できる枚数を一枚にする
        configuration.selectionLimit = 1
        // PHPickerViewControllerのインスタンスを生成
        let picker = PHPickerViewController(configuration: configuration)
        // delegateを設定
        picker.delegate = context.coordinator
        // PHPickerViewControllerを返す
        return picker
    }

    // Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PHPickerView>) {
        // 処理なし
    }
}
