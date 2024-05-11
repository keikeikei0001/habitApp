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
    @Environment(\.dismiss) private var dismiss
    
    private let taskDataManager: TaskDataManager = TaskDataManager()
    private let characterDataManager: CharacterDataManager = CharacterDataManager()
    private let now = Date().zeroclock
    
    init(taskData: TaskData) {
        self.taskData = taskData
    }
    
    /// タスク完了時の処理
    func taskDone() async {
        // 対象のタスクの継続回数に1を足す
        taskData.continationCount += 1
        await taskDataManager.doneTask(taskData: taskData) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("TaskData update successfully.")
            }
        }
        var characterDataArray = await characterDataManager.fetchCharacter()
        if let characterData = characterDataArray.first(where: {$0.id == "kumaneko0001"}) {
            // 対象キャラクターの総保有経験値に1を足す
            await characterDataManager.getExperiencePoint(characterData: characterData) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("CharacterData update successfully.")
                }
            }
        }
        // タスク完了ボタンを非活性
        buttonEnable.toggle()
    }
    
    /// タスク削除時の処理
    func taskDelete() async {
        // 遷移元に戻る
        dismiss()
        await taskDataManager.deleteTask(taskData: taskData) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("taskData delete successfully.")
            }
        }
    }
    
    func taskDoneButton() {
        // タスクを1回でも行い、タスク情報.最終完了日が今日の場合、タスク完了ボタンを非活性にする
        if taskData.lastDoneDate == now && taskData.continationCount != 0 {
            buttonEnable = false
        }
    }
}
