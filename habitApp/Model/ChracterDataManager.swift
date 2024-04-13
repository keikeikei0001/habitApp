//
//  UserViewModel.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/11.
//

import FirebaseFirestore

class CharacterData: ObservableObject {
    private var db = Firestore.firestore()
    // struct Userをデータ型に使う
    @Published var users: [User] = []
    
    // データの追加をするメソッド
    func saveUser(name: String, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("users").document()
        
        let user = User(id: docRef.documentID, name: name, createdAt: Timestamp())
        
        docRef.setData([
            "id": user.id,
            "name": user.name,
            "createdAt": user.createdAt
        ]) { error in
            completion(error)
        }
    }
    
    // データを取得して表示するメソッド
    func fetchUsers() {
        db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.users = snapshot?.documents.map {
                    User(id: $0.documentID,
                         name: $0.data()["name"] as? String ?? "",
                         createdAt: $0.data()["createdAt"] as? Timestamp ?? Timestamp())
                } ?? []
            }
        }
    }
}
