//
//  File.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/30.
//

import SwiftUI

class TaskAddViewModel: ObservableObject {
    @Published var isTaskAddView: Bool = false
    @Published var inputTaskName = ""
    
    private let taskDataManager: TaskDataManager = TaskDataManager()
    
    /// タスク追加ボタン押下時
    func taskAdd() async {
        // タスク追加処理
        let _ = await taskDataManager.saveTask(taskName: inputTaskName)
    }
}

