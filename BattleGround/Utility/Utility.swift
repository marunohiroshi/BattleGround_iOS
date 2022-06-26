//
//  Utility.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/14.
//

import Foundation
import UIKit

struct Utility {
    var selectedDeckType: [String]

    init(selectedDeckType: [String]) {
        self.selectedDeckType = selectedDeckType
    }

    static func convertImageToBase64(image: UIImage?) -> String? {
        guard let imageData = image?.jpegData(compressionQuality: 1.0) else { return nil }
        return imageData.base64EncodedString()
    }

    static func convertBase64ToImage(base64String: String?) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String ?? "") else { return nil }
        return UIImage(data: imageData)
    }
}
