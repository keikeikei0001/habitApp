//
//  TaskManager.swift
//  ToDoList
//
//  Created by satorikuto on 2022/09/14.
//

import Foundation

//タスク保存用class
class TaskManager {
    let us = UserDefaults.standard
    
    func saveTask(taskArray: [TaskData], forKey: String) {
        let jsonEncoder = JSONEncoder()
        guard let data = try? jsonEncoder.encode(taskArray) else { return }
        us.set(data, forKey: forKey)
    }
    
    func loadTask(forKey: String) -> [TaskData]? {
        let jsonDecoder = JSONDecoder()
        guard let data = us.data(forKey: forKey),
              let taskArray = try? jsonDecoder.decode([TaskData].self, from: data) else {
            return nil
        }
        return taskArray
    }
}
