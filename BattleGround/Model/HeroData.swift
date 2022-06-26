//
//  HeroData.swift
//  BattleGround
//
//  Created by 丸野拓志 on 2022/05/15.
//

import Foundation
import SwiftUI

struct HeroData {
    var heroName: String
    var heroImage: UIImage?

    static let heroDataList = [
        HeroData(heroName: "リッチのバズィアル", heroImage: UIImage(named: "hero01")),
        HeroData(heroName: "キュレーター", heroImage: UIImage(named: "hero02")),
        HeroData(heroName: "キング・ムクラ", heroImage: UIImage(named: "hero03")),
        HeroData(heroName: "ケルサス・サンストライダー", heroImage: UIImage(named: "hero04")),
        HeroData(heroName: "デスウィング", heroImage: UIImage(named: "hero05")),
        HeroData(heroName: "ロード・ジャラクサス", heroImage: UIImage(named: "hero06")),
        HeroData(heroName: "希望の終焉ヨグ＝サロン", heroImage: UIImage(named: "hero07")),
        HeroData(heroName: "クトゥーン", heroImage: UIImage(named: "hero08")),
        HeroData(heroName: "ゲイルウィング", heroImage: UIImage(named: "hero09")),
        HeroData(heroName: "テス・グレイメイン", heroImage: UIImage(named: "hero10")),
        HeroData(heroName: "ミリフィセント・マナストーム", heroImage: UIImage(named: "hero11")),
        HeroData(heroName: "ン＝ゾス", heroImage: UIImage(named: "hero12")),
        HeroData(heroName: "炎の王ラグナロス", heroImage: UIImage(named: "hero13")),
        HeroData(heroName: "イセラ", heroImage: UIImage(named: "hero14")),
        HeroData(heroName: "パッチウァーク", heroImage: UIImage(named: "hero15")),
        HeroData(heroName: "アランナ・スターシーカー", heroImage: UIImage(named: "hero16")),
        HeroData(heroName: "ジャンディス・バロフ", heroImage: UIImage(named: "hero17")),
        HeroData(heroName: "アラキア", heroImage: UIImage(named: "hero18")),
        HeroData(heroName: "灰枝", heroImage: UIImage(named: "hero19")),
        HeroData(heroName: "死の説教師ブラックソーン", heroImage: UIImage(named: "hero20")),
        HeroData(heroName: "ガラクロンド", heroImage: UIImage(named: "hero21")),
        HeroData(heroName: "ノズドルム", heroImage: UIImage(named: "hero22")),
        HeroData(heroName: "キャリエル・ローム", heroImage: UIImage(named: "hero23")),
        HeroData(heroName: "商大公ガリーウィックス", heroImage: UIImage(named: "hero24")),
        HeroData(heroName: "ヤシャラージュ", heroImage: UIImage(named: "hero25")),
        HeroData(heroName: "ダンシン・ダリル", heroImage: UIImage(named: "hero26")),
        HeroData(heroName: "ガフ・ルーントーテム", heroImage: UIImage(named: "hero27")),
        HeroData(heroName: "ワグトグル女王", heroImage: UIImage(named: "hero28")),
        HeroData(heroName: "ラカニシュ", heroImage: UIImage(named: "hero29")),
        HeroData(heroName: "地獄のジョージ", heroImage: UIImage(named: "hero30")),
        HeroData(heroName: "シャダウォック", heroImage: UIImage(named: "hero31")),
        HeroData(heroName: "ネズミの王", heroImage: UIImage(named: "hero32")),
        HeroData(heroName: "チケッタス", heroImage: UIImage(named: "hero33")),
        HeroData(heroName: "エドウィン・ヴァンクリーフ", heroImage: UIImage(named: "hero34")),
        HeroData(heroName: "マスター・ウェン", heroImage: UIImage(named: "hero35")),
        HeroData(heroName: "森番オム", heroImage: UIImage(named: "hero36")),
        HeroData(heroName: "無限のトキ", heroImage: UIImage(named: "hero37")),
        HeroData(heroName: "イリダン・ストームレイジ", heroImage: UIImage(named: "hero38")),
        HeroData(heroName: "空賊船長クラッグ", heroImage: UIImage(named: "hero39")),
        HeroData(heroName: "サー・フィンレー・マルグルトン", heroImage: UIImage(named: "hero40")),
        HeroData(heroName: "A. F. ケイ", heroImage: UIImage(named: "hero41")),
        HeroData(heroName: "レノ・ジャクソン", heroImage: UIImage(named: "hero42")),
        HeroData(heroName: "シンドラゴサ", heroImage: UIImage(named: "hero43")),
        HeroData(heroName: "海賊パッチーズ", heroImage: UIImage(named: "hero44")),
        HeroData(heroName: "恐竜使いブラン", heroImage: UIImage(named: "hero45")),
        HeroData(heroName: "マイエヴ・シャドウソング", heroImage: UIImage(named: "hero46")),
        HeroData(heroName: "ロード・バロフ", heroImage: UIImage(named: "hero47")),
        HeroData(heroName: "ザイレラ", heroImage: UIImage(named: "hero48")),
        HeroData(heroName: "アレクストラーザ", heroImage: UIImage(named: "hero49")),
        HeroData(heroName: "偉大なるゼフリス", heroImage: UIImage(named: "hero50")),
        HeroData(heroName: "サイラス・ダークムーン", heroImage: UIImage(named: "hero51")),
        HeroData(heroName: "ビグルスワース君", heroImage: UIImage(named: "hero52")),
        HeroData(heroName: "ユードラ船長", heroImage: UIImage(named: "hero53")),
        HeroData(heroName: "貪り喰らうものミュターヌス", heroImage: UIImage(named: "hero54")),
        HeroData(heroName: "サウルファング元帥", heroImage: UIImage(named: "hero55")),
        HeroData(heroName: "菌術師フラァグル", heroImage: UIImage(named: "hero56")),
        HeroData(heroName: "マリゴス", heroImage: UIImage(named: "hero57")),
        HeroData(heroName: "シェンヴァーラ", heroImage: UIImage(named: "hero58")),
        HeroData(heroName: "スニード", heroImage: UIImage(named: "hero59")),
        HeroData(heroName: "コックのクッキー", heroImage: UIImage(named: "hero60")),
        HeroData(heroName: "ロカラ", heroImage: UIImage(named: "hero61")),
        HeroData(heroName: "タムシン・ローム", heroImage: UIImage(named: "hero62")),
        HeroData(heroName: "ヴァンダル・ストームパイク", heroImage: UIImage(named: "hero63")),
        HeroData(heroName: "ドレクサー", heroImage: UIImage(named: "hero64")),
        HeroData(heroName: "オニクシア", heroImage: UIImage(named: "hero65")),
        HeroData(heroName: "タヴィッシュ・ストームパイク", heroImage: UIImage(named: "hero66")),
        HeroData(heroName: "ヴァーデン・ドーングラスプ", heroImage: UIImage(named: "hero67")),
        HeroData(heroName: "フェイリン大使", heroImage: UIImage(named: "hero68")),
        HeroData(heroName: "イニ・ストームコイル", heroImage: UIImage(named: "hero69")),
        HeroData(heroName: "アズシャラ女王", heroImage: UIImage(named: "hero70")),
        HeroData(heroName: "リッチキング", heroImage: UIImage(named: "hero71")),
        HeroData(heroName: "ミルハウス・マナストーム", heroImage: UIImage(named: "hero72")),
        HeroData(heroName: "カートラス・アッシュフォールン", heroImage: UIImage(named: "hero73")),
        HeroData(heroName: "オズマット", heroImage: UIImage(named: "hero74")),
        HeroData(heroName: "ディアブロ", heroImage: UIImage(named: "hero75")),
        HeroData(heroName: "偉大なるアカザムザラク", heroImage: UIImage(named: "hero76")),
        HeroData(heroName: "エリーズ・スターシーカー", heroImage: UIImage(named: "hero77")),
        HeroData(heroName: "ピラマッド", heroImage: UIImage(named: "hero78")),
        HeroData(heroName: "ヴォルジン", heroImage: UIImage(named: "hero79"))
    ]

    // HeroDataからImageを取り出しList化する
    static let heroImageList = HeroData.heroDataList.map({ heroData -> UIImage? in
        heroData.heroImage ?? UIImage(named: "hero01")
    })
}
