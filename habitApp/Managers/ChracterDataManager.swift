//
//  CharacterdataManager.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/11.
//

// TODO: - ChatGPTにCharacterDataManagerのコードを綺麗にしてもらう。

// このファイルは、Firebase Firestoreを使ってキャラクター情報を管理するクラスを定義しています。
// CharacterDataManagerクラスは、キャラクターのデータ保存・更新・取得を行うメソッドを提供しています。

import FirebaseFirestore  // FirebaseのFirestoreデータベースを使用するためのインポート

class CharacterDataManager: ObservableObject {
    // Firestoreのデータベースインスタンスを初期化
    private var db = Firestore.firestore()
    
    // ユーザーの情報を保存・取得するためのUserDefaultsインスタンスを取得
    private let us = UserDefaults.standard
    
    /// キャラクター情報の追加を行うメソッド
    /// - Parameters:
    ///   - id: キャラクターの一意の識別子
    ///   - name: キャラクターの名前
    ///   - completion: データ保存が完了した際に実行されるクロージャ（エラーがあれば返す）
    func saveCharacter(id: String, name: String, completion: @escaping (Error?) -> Void) async {
        // UserDefaultsからユーザーIDを取得（保存されていない場合は空文字列を使用）
        let userId = us.string(forKey: "userId") ?? ""
        
        // Firestoreの特定のユーザーのキャラクターデータコレクションに、新しいドキュメントを作成
        let docRef = db.collection("user/\(userId)/characterData").document(id)
        
        // 新しいキャラクターのデータを作成
        let characterData = CharacterData(id: docRef.documentID, name: name, allExperiencePoint: 0)
        
        do {
            // Firestoreにキャラクターデータを保存（非同期処理）
            try await docRef.setData([
                "id": characterData.id,
                "name": characterData.name,
                "allExperiencePoint": characterData.allExperiencePoint
            ])
            completion(nil)  // 保存に成功した場合、エラーなしでcompletionを実行
        } catch {
            completion(error)  // 保存に失敗した場合、エラーを渡してcompletionを実行
        }
    }
    
    /// 対象キャラクターの経験値に1を加算するメソッド
    /// - Parameters:
    ///   - characterData: 更新するキャラクターのデータ
    ///   - completion: 更新が完了した際に実行されるクロージャ（エラーがあれば返す）
    /// - Returns: 更新後に全てのキャラクターデータを取得して返す
    func getExperiencePoint(characterData: CharacterData, completion: @escaping (Error?) -> Void) async -> [CharacterData] {
        // UserDefaultsからユーザーIDを取得
        let userId = us.string(forKey: "userId") ?? ""
        
        // Firestoreの特定のキャラクタードキュメントを参照
        let docRef = db.collection("user/\(userId)/characterData").document(characterData.id)
        
        do {
            // キャラクターの経験値を1増加させてデータを更新（非同期処理）
            try await docRef.updateData([
                "allExperiencePoint": characterData.allExperiencePoint + 1
            ])
            completion(nil)  // 更新に成功した場合、エラーなしでcompletionを実行
        } catch {
            completion(error)  // 更新に失敗した場合、エラーを渡してcompletionを実行
        }
        
        // 更新後にキャラクターデータを取得して返す
        return await fetchCharacter()
    }
    
    /// キャラクター情報をFirestoreから取得して配列で返すメソッド
    /// - Returns: 取得した全キャラクターのデータの配列
    func fetchCharacter() async -> [CharacterData] {
        // UserDefaultsからユーザーIDを取得
        let userId = us.string(forKey: "userId") ?? ""
        
        // キャラクターのデータを保持する配列
        var characterDataArray: [CharacterData] = []
        
        do {
            // Firestoreからキャラクターデータを取得（非同期処理）
            let snapshot = try await db.collection("user/\(userId)/characterData").getDocuments()
            
            // 取得したドキュメントをキャラクターデータに変換して配列に格納
            characterDataArray = snapshot.documents.map {
                CharacterData(id: $0.documentID, name: $0.data()["name"] as? String ?? "クマネコ",
                              allExperiencePoint: $0.data()["allExperiencePoint"] as? Int ?? 0)
            }
        } catch {
            // データ取得時にエラーが発生した場合はエラーメッセージを表示
            print("Error getting characeterData: \(error)")
        }
        
        // キャラクターデータの配列を返す
        return characterDataArray
    }
}
