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
    var getLevel: Int {
        Int(floor(Double(allExperiencePoint / 5))) + 1
    }
}
