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
    func handleOnAppear() {
        if let _ = us.string(forKey: "userId") {
            getCharacterData()
        } else {
            createUser()
        }
    }
    
    /// ユーザーを作成する処理
    private func createUser() {
        Task {
            await createUserId()
            await createCharacterData()
        }
    }
    
    /// ユーザーIDを作成する処理
    private func createUserId() async {
        us.set(UUID().uuidString, forKey: "userId")
    }
    
    /// キャラクター情報を取得する処理
    private func getCharacterData() {
        Task {
            let  newCharacterData = await characterDataManager.fetchCharacter()
            DispatchQueue.main.async {
                self.characterDataArray = newCharacterData
            }
        }
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
        getCharacterData()
    }
}
