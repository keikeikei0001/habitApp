//
//  TaskListView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct TaskListView: View {
    // タスク情報
    @EnvironmentObject private var taskObject: TaskObject
    // モーダル遷移フラグ
    @State private var isTaskAddView = false
    
    var body: some View {
        // タスクテーブル
        taskTableView()
            .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        // ナビゲーションの右側に＋ボタンを配置
        // ボタン押下時、TaskAddViewに遷移する
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isTaskAddView = true
            } label: {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $isTaskAddView) {
                TaskAddView( isTaskAddView: $isTaskAddView)
            }
        }
    }
    
    /// タスクテーブル
    @ViewBuilder
    private func taskTableView() -> some View {
        List(Array(taskObject.taskData.enumerated()), id: \.element.taskId) { index, taskData in
            NavigationLink(destination: TaskCountView(index: index)) {
                // タスクテーブルセル
                taskTableCellView(taskData: taskData)
            }
        }
    }
    
    /// タスクのテーブルセル
    @ViewBuilder
    private func taskTableCellView(taskData: TaskData) -> some View {
        HStack {
            // タスク情報.タスク名
            Text(taskData.taskName)
            Spacer()
            // タスク情報.継続回数
            Text("\(taskData.continationCount)")
        }
    }
}
