//
//  LevelSet.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import Foundation
//レベル計算メソッド
func levelSet(allExperiencePoint:Int) -> Int {
    let levelPoint = Int(floor(Double(allExperiencePoint / 5))) + 1
    return levelPoint
}
