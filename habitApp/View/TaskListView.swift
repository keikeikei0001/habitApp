//
//  TaskListView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var isTaskSelected = false
    @State private var selectedTask: TaskData?
    
    var body: some View {
        NavigationStack {
            taskTableView()
                .onAppear(perform: viewModel.reloadTask)
                .navigationDestination(isPresented: $isTaskSelected) {
                    if let taskData = selectedTask {
                        TaskCountView(viewModel: TaskCountViewModel(taskData: taskData))
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    FloatingActionButtonView()
                        .padding()
                        .sheet(isPresented: $viewModel.isTaskAddView, onDismiss: viewModel.reloadTask) {
                            TaskAddView(isTaskAddView: $viewModel.isTaskAddView)
                        }
                }
        }
    }
    
    /// タスクテーブル
    @ViewBuilder
    private func taskTableView() -> some View {
        List {
            ForEach(viewModel.sectionTitles, id: \.self) { section in
                Section(header: Text(section)) {
                    if let tasks = viewModel.groupedTaskData[section], !tasks.isEmpty {
                        ForEach(tasks) { taskData in
                            taskTableCellView(taskData: taskData)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedTask = taskData
                                    isTaskSelected = true
                                }
                        }
                    } else {
                        Text("No Tasks").foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    /// タスクのテーブルセル
    @ViewBuilder
    private func taskTableCellView(taskData: TaskData) -> some View {
        HStack {
            Text(taskData.taskName)
            Spacer()
            VStack {
                Text("継続")
                    .font(.system(size: 10))
                Text("\(taskData.continationCount)")
            }
            VStack {
                Text("復帰")
                    .font(.system(size: 10))
                Text("\(taskData.recoveryCount)")
            }
        }
    }
    
    /// 追加ボタン
    @ViewBuilder
    private func FloatingActionButtonView() -> some View {
        Button(action: viewModel.handleAddButtonTap) {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(18)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .frame(width: 66, height: 66)
    }
}

