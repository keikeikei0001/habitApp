//
//  TaskDataManager.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/12.
//

import FirebaseFirestore

class TaskDataManager: ObservableObject {
    private var db = Firestore.firestore()
    private let us = UserDefaults.standard
    
    // タスク情報の追加をするメソッド
    func savetask(taskName: String, completion: @escaping (Error?) -> Void) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document()
        
        let taskData = TaskData(id: docRef.documentID, taskName: taskName, continationCount: 0, lastDoneDate: Date().zeroclock, createDate: Date().zeroclock)
        
        docRef.setData([
            "id": taskData.id,
            "taskName": taskData.taskName,
            "continationCount": taskData.continationCount,
            "lastDoneDate": taskData.lastDoneDate,
            "createDate": taskData.createDate
        ]) { error in
            completion(error)
        }
        var taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスクを完了した際の処理
    func doneTask(taskData: TaskData, completion: @escaping (Error?) -> Void) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document(taskData.id)
        docRef.updateData([
            "continationCount": taskData.continationCount
        ]) { error in
            completion(error)
        }
        var taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスク削除時の処理
    func deleteTask(taskData: TaskData, completion: @escaping (Error?) -> Void) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document(taskData.id)
        
        docRef.delete() { error in
            completion(error)
        }
        var taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスク情報を取得して表示するメソッド
    func fetchTask() async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        var taskDataArray: [TaskData] = []
        
        db.collection("user/\(userId)/taskData").getDocuments { snapshot, error in
            if let error = error {
                print("Error getting taskData: \(error)")
            } else {
                taskDataArray = snapshot?.documents.map {
                    TaskData(id: $0.documentID, taskName: $0.data()["taskName"] as? String ?? "", continationCount: $0.data()["continationCount"] as? Int ?? 0, lastDoneDate: $0.data()["lastDoneDate"] as? Date ?? Date().zeroclock, createDate: $0.data()["createDate"] as? Date ?? Date().zeroclock)
                } ?? []
            }
        }
        return taskDataArray
    }
}

