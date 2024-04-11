//
//  TaskManager.swift
//  ToDoList
//
//  Created by satorikuto on 2022/09/14.
//

import Foundation

class TaskManager {
    let us = UserDefaults.standard
    /// タスク情報保存
    func saveTask(taskArray: [TaskData], forKey: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(taskArray) else { return }
        us.set(data, forKey: forKey)
    }
    
    /// タスク情報取得
    func loadTask(forKey: String) -> [TaskData]? {
        let jsonDecoder = JSONDecoder()
        guard let data = us.data(forKey: forKey),
              let taskArray = try? jsonDecoder.decode([TaskData].self, from: data) else {
            return nil
        }
        return taskArray
    }
}
