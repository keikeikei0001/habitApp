//
//  TaskListView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    
    var body: some View {
        // タスクテーブル
        taskTableView()
            .toolbar(content: toolbarContent)
            .onAppear(perform: viewModel.reloadTask)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        // ナビゲーションの右側に＋ボタンを配置
        // ボタン押下時、TaskAddViewに遷移する
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: viewModel.handleAddButtonTap) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $viewModel.isTaskAddView, onDismiss: viewModel.reloadTask) {
                TaskAddView(isTaskAddView: $viewModel.isTaskAddView)
            }
        }
    }
    
    /// タスクテーブル
    @ViewBuilder
    private func taskTableView() -> some View {
        List(viewModel.tableTaskData) { taskData in
            NavigationLink(destination: TaskCountView(viewModel: TaskCountViewModel(taskData:taskData))) {
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
