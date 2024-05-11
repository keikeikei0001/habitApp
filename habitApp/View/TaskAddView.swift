//
//  TaskAddView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

struct TaskAddView: View {
    @StateObject var viewModel: TaskAddViewModel = TaskAddViewModel()
    @FocusState private var isFocused: Bool
    @Binding var isTaskAddView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            // タスク名入力用テキストフィールド
            taskTextFieldView()
            Spacer()
            // タスク追加ボタン
            taskAddButtonView()
            Spacer()
        }
    }
    
    /// タスク名入力用テキストフィールド
    @ViewBuilder
    private func taskTextFieldView() -> some View {
        // 画面.タスク入力テキストフィールド
        TextField("タスク名を入力してください", text: $viewModel.inputTaskName)
            .textFieldStyle(.roundedBorder)
            .padding()
            .focused($isFocused)
    }
    
    /// タスク追加ボタン
    @ViewBuilder
    private func taskAddButtonView() -> some View {
        Button {
            Task {
                await viewModel.taskAdd()
                isFocused = false
                viewModel.isTaskAddView = false
            }
        } label: {
            Text("Create")
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.title)
                .cornerRadius(10)
        }
    }
}
