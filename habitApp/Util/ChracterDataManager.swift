//
//  CharacterdataManager.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/11.
//

import FirebaseFirestore

class CharacterDataManager: ObservableObject {
    private var db = Firestore.firestore()
    private let us = UserDefaults.standard
    
    // キャラクター情報の追加をするメソッド
    func saveCharacter(id: String, name: String, completion: @escaping (Error?) -> Void) async {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/characterData").document(id)
        
        let characterData = CharacterData(id: docRef.documentID, name: name, allExperiencePoint: 0)
        
        docRef.setData([
            "id": characterData.id,
            "name": characterData.name,
            "allExperiencePoint": characterData.allExperiencePoint
        ]) { error in
            completion(error)
        }
        await fetchCharacter()
    }
    
    // 対象キャラクターの経験値に1を足す
    func getExperiencePoint(characterData: CharacterData, completion: @escaping (Error?) -> Void) async {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/characterData").document(characterData.id)
        
        docRef.updateData([
            "allExperiencePoint": characterData.allExperiencePoint + 1
        ]) { error in
            completion(error)
        }
        await fetchCharacter()
    }
    
    // キャラクター情報を取得して表示するメソッド
    func fetchCharacter() async {
        let userId = us.string(forKey: "userId") ?? ""
        
        var characterDataArray: [CharacterData] = []
        
        db.collection("user/\(userId)/characterData").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting characeterData: \(error)")
            } else {
                characterDataArray = snapshot?.documents.map {
                    CharacterData(id: $0.documentID, name: $0.data()["name"] as? String ?? "クマネコ",
                                  allExperiencePoint: $0.data()["allExperiencePoint"] as? Int ?? 0)
                } ?? []
            }
        }
    }
}
