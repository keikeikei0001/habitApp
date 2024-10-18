//
//  MainViewModel.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/06.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var characterDataArray: [CharacterData] = []
    
    private let characterDataManager = CharacterDataManager()
    private let us = UserDefaults.standard
    
    /// 画面表示時に呼ばれる
    func onAppear() {
        if us.string(forKey: "userId") == "" {
            createUserId()
        }
        
        Task {
            await getCharacterData()
            if characterDataArray.isEmpty {
                await createCharacterData()
            }
        }
    }
    
    /// ユーザーIDを作成する処理
    private func createUserId() {
        let uuid = UUID().uuidString
        us.set(uuid, forKey: "userId")
    }
    
    /// 情報取得メソッド
    private func getCharacterData() async {
        let  newCharacterData = await characterDataManager.fetchCharacter()
        characterDataArray = newCharacterData
    }
    
    /// キャラクター情報新規作成
    private func createCharacterData() async {
        await characterDataManager.saveCharacter(id: "kumaneko0001", name: "安倍　晋三") { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Character create successfully.")
            }
        }
        // キャラクター情報取得
        let  newCharacterData = await characterDataManager.fetchCharacter()
        characterDataArray = newCharacterData
    }
}
