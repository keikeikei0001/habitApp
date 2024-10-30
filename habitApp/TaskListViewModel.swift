//
//  TaskListViewModel.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/04.
//

import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var isTaskAddView: Bool = false
    @Published var tableTaskData: [TaskData] = []
    
    private let taskDataManager = TaskDataManager()
    
    func fetchTaskData() async {
        let  newTaskData = await taskDataManager.fetchTask()
        DispatchQueue.main.async {
            // キャラクター情報取得
            self.tableTaskData = newTaskData
        }
    }
    /// 画面表示時に呼ばれる
    func reloadTask() {
        Task {
            await fetchTaskData()
        }
    }
    
    /// ナビゲーションの右側のプラスボタンタップ
    func handleAddButtonTap() {
        isTaskAddView = true
    }
}
