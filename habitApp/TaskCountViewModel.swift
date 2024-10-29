//
//  TaskCountView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/07.
//

import SwiftUI

class TaskCountViewModel: ObservableObject {
    @Published var buttonEnable: Bool = true
    @Published var taskData: TaskData
    private var dismissAction: (() -> Void)?
    
    private let taskDataManager: TaskDataManager = TaskDataManager()
    private let characterDataManager: CharacterDataManager = CharacterDataManager()
    private let now = Date().zeroclock
    
    init(taskData: TaskData) {
        self.taskData = taskData
    }
    
    /// `dismiss`アクションを設定
    func setDismissAction(_ action: @escaping () -> Void) {
        dismissAction = action
    }
    
    /// タスク完了時の処理
    func taskDone() async {
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
        
        DispatchQueue.main.async {
            self.buttonEnable.toggle()
        }
    }
    
    /// タスク削除時の処理
    func taskDelete() async {
        // Viewのdismissアクションを呼び出す
        DispatchQueue.main.async {
            self.dismissAction?()
        }
        
        let _ = await taskDataManager.deleteTask(taskData: taskData)
    }
    
    func taskDoneButton() {
        if taskData.lastDoneDate == now && taskData.continationCount != 0 {
            buttonEnable = false
        }
    }
}
