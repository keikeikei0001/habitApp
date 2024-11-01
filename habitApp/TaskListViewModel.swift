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
    let sectionTitles = ["朝", "昼", "夜", "フリー"]
    private let taskDataManager = TaskDataManager()
    
    var groupedTaskData: [String: [TaskData]] {
        var groupedData = Dictionary(grouping: tableTaskData, by: { $0.taskSection })
        for title in sectionTitles {
            groupedData[title] = groupedData[title] ?? []
        }
        return groupedData
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
    
    private func fetchTaskData() async {
        let  newTaskData = await taskDataManager.fetchTask()
        DispatchQueue.main.async {
            // キャラクター情報取得
            self.tableTaskData = newTaskData
        }
    }
}
