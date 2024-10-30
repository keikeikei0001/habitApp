//
//  TaskCountView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/07.
//

import SwiftUI

class TaskCountViewModel: ObservableObject {
    @Published var taskData: TaskData
    
    private let taskDataManager = TaskDataManager()
    private let characterDataManager = CharacterDataManager()
    
    init(taskData: TaskData) {
        self.taskData = taskData
    }
    
    /// タスクボタンが有効かどうか
    var enableTaskCountButton: Bool {
        taskData.lastDoneDate == Date().zeroclock && taskData.continationCount != 0
    }
    
    /// 削除ボタンタップ
    func handleDeleteButtonTap() {
        Task {
            await deleteTask()
        }
    }
    
    /// タスク完了ボタンタップ
    func handleTaskCountButtonTap() {
        Task {
            await updateContinationCount()
        }
    }
    
    /// タスク完了時の処理
    private func updateContinationCount() async {
        DispatchQueue.main.async {
            self.taskData.continationCount += 1
        }
        
        let _ = await taskDataManager.doneTask(taskData: taskData)
        let characterDataArray = await characterDataManager.fetchCharacter()
        
        if let characterData = characterDataArray.first(where: {$0.id == "kumaneko0001"}) {
            _ = await characterDataManager.getExperiencePoint(characterData: characterData) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("CharacterData update successfully.")
                }
            }
        }
    }
    
    /// タスク削除時の処理
    func deleteTask() async {
        _ = await taskDataManager.deleteTask(taskData: taskData)
    }
}
