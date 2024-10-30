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
    func saveTask(taskName: String) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document()
        
        let taskData = TaskData(id: docRef.documentID, taskName: taskName, continationCount: 0, lastDoneDate: Date().zeroclock, createDate: Date().zeroclock)
        
        // 非同期のsetDataを使用
        do {
            try await docRef.setData([
                "id": taskData.id,
                "taskName": taskData.taskName,
                "continationCount": taskData.continationCount,
                "lastDoneDate": taskData.lastDoneDate,
                "createDate": taskData.createDate
            ])
        } catch {
            print("Error saving task: \(error)")
        }
        
        let taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスクを完了した際の処理
    func doneTask(taskData: TaskData) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document(taskData.id)
        
        // 非同期のupdateDataを使用
        print("🟥\(taskData.continationCount)")
        do {
            try await docRef.updateData([
                "continationCount": taskData.continationCount
            ])
        } catch {
            print("Error updating task: \(error)")
        }
        
        let taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスク削除時の処理
    func deleteTask(taskData: TaskData) async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        let docRef = db.collection("user/\(userId)/taskData").document(taskData.id)
        
        // 非同期のdeleteを使用
        do {
            try await docRef.delete()
        } catch {
            print("Error deleting task: \(error)")
        }
        
        let taskDataArray = await fetchTask()
        return taskDataArray
    }
    
    // タスク情報を取得して表示するメソッド
    func fetchTask() async -> [TaskData] {
        let userId = us.string(forKey: "userId") ?? ""
        
        var taskDataArray: [TaskData] = []
        
        do {
            let snapshot = try await db.collection("user/\(userId)/taskData").getDocuments()
            taskDataArray = snapshot.documents.map {
                TaskData(
                    id: $0.documentID,
                    taskName: $0.data()["taskName"] as? String ?? "",
                    continationCount: $0.data()["continationCount"] as? Int ?? 0,
                    lastDoneDate: $0.data()["lastDoneDate"] as? Date ?? Date().zeroclock,
                    createDate: $0.data()["createDate"] as? Date ?? Date().zeroclock
                )
            }
        } catch {
            print("Error getting taskData: \(error)")
        }
        return taskDataArray
    }
}


