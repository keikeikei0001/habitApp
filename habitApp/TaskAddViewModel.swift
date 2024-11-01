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
    private let taskDataManager = TaskDataManager()
    @Published var selectedtaskSection = taskSections.morning
    
    enum taskSections: String, CaseIterable, Identifiable {
        case morning = "朝"
        case noon = "昼"
        case nignt = "夜"
        case free = "フリー"
        
        var id: String { rawValue }
    }
    
    
    /// 追加ボタンタップ時
    @MainActor
    func handleAddButtonTap(taskSection: String) {
        Task {
            await addTask(taskSection: taskSection)
            isTaskAddView = false
        }
    }
    
    /// タスク追加処理
    private func addTask(taskSection: String) async {
        // タスク追加処理
        let _ = await taskDataManager.saveTask(taskName: inputTaskName, taskSection: taskSection)
    }
}

