//
//  MainViewModel.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/06.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var characterDataArray: [CharacterData] = []
    @Published var isTaskAddView: Bool = false
    @Published var isLoading = true
    
    private let characterDataManager: CharacterDataManager = CharacterDataManager()
    private let us = UserDefaults.standard
    
    /// 情報取得メソッド
    func dataGet() async {
        // ユーザーIDを取得する
        let userId = us.string(forKey: "userId") ?? ""
        
        if userId == "" {
            us.set("\(UUID())", forKey: "userId")
        }
        // キャラクター情報取得
        let  newCharacterData = await characterDataManager.fetchCharacter()
        DispatchQueue.main.async {
            self.characterDataArray = newCharacterData
        }
    }
    
    /// キャラクター情報新規作成
    func characterCreate() async {
        if characterDataArray.count == 0 {
            await characterDataManager.saveCharacter(id: "kumaneko0001", name: "安倍　晋三") { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Character create successfully.")
                }
            }
            // キャラクター情報取得
            let  newCharacterData = await characterDataManager.fetchCharacter()
            DispatchQueue.main.async {
                self.characterDataArray = newCharacterData
            }
        }
    }
}
