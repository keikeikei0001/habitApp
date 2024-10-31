//
//  CharacterData.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/04.
//

import FirebaseFirestore

/// キャラクター情報
struct CharacterData: Identifiable {
    /// キャラクターID
    var id: String
    /// キャラクター名
    var name: String
    /// 総保有経験値
    var allExperiencePoint: Int
    
    /// 総保有経験値からレベルを計算
    var level: Int {
        // レベル
        var level = 1
        // 必要経験値
        var needExperience = 4
        // レベルアップ時の必要経験値の増加値
        var incrementNeedExperience = 4
        // 特殊レベル(必要経験値の増加値が今までより多くなるレベル)
        var specialLevel = 2
        // 特殊レベルの場合に今までより必要経験値を増やすための値
        let specialIncrementNeedExperience = 4
        // 特殊レベルの設定に使用する値
        var specialLevelSettingPoint = 1
        
        while allExperiencePoint >= needExperience {
            level += 1
            needExperience += incrementNeedExperience
            // レベルが特殊レベルの場合
            if level == specialLevel {
                needExperience += specialIncrementNeedExperience
                incrementNeedExperience += specialIncrementNeedExperience
                specialLevelSettingPoint += 1
                specialLevel += specialLevelSettingPoint
            }
        }
        return level
    }
}


