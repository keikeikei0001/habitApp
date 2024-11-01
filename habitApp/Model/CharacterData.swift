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
    /// レベルに関する情報(レベル、保有経験値、必要経験値)
    var levelInfo: (Int, Int, Int) {
        // レベル
        var level = 1
        // 総必要経験値
        var totalNeedExperience = 4
        // 現在必要経験値
        var currentNeedExperience = 0
        // 保有経験値
        var experiencePoint = 0
        // 前回必要経験値
        var needExperienceBeffore = 0
        // レベルアップ時の総必要経験値の増加値
        var incrementTotalNeedExperience = 4
        // 特殊レベル(総必要経験値の増加値が今までより多くなるレベル)
        var specialLevel = 2
        // 特殊レベルの場合に今までより総必要経験値の増加値を増やすための値
        let specialIncrementTotalNeedExperience = 4
        // 特殊レベルの設定に使用する値
        var specialLevelSettingPoint = 1
        
        while allExperiencePoint >= totalNeedExperience {
            level += 1
            needExperienceBeffore = totalNeedExperience
            totalNeedExperience += incrementTotalNeedExperience
            // レベルが特殊レベルの場合
            if level == specialLevel {
                totalNeedExperience += specialIncrementTotalNeedExperience
                incrementTotalNeedExperience += specialIncrementTotalNeedExperience
                specialLevelSettingPoint += 1
                specialLevel += specialLevelSettingPoint
            }
        }
        experiencePoint = allExperiencePoint - needExperienceBeffore
        currentNeedExperience = totalNeedExperience - needExperienceBeffore
        return (level, experiencePoint, currentNeedExperience)
    }
}


