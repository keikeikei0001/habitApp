//
//  CharacterDataView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import Foundation

class CharacterManager {
    let us = UserDefaults.standard
    /// キャラクター情報保存
    func saveTask(taskArray: CharacterData, forKey: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(taskArray) else { return }
        us.set(data, forKey: forKey)
    }
    
    /// キャラクター情報取得
    func loadTask(forKey: String) -> CharacterData {
        let jsonDecoder = JSONDecoder()
        guard let data = us.data(forKey: forKey),
              let taskArray = try? jsonDecoder.decode(CharacterData.self, from: data) else {
            return CharacterData()
        }
        return taskArray
    }
}
