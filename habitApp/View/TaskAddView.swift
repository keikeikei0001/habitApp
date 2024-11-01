//
//  TaskAddView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

struct TaskAddView: View {
    @StateObject private var viewModel = TaskAddViewModel()
    @FocusState private var isFocused: Bool
    @Binding var isTaskAddView: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            taskSectionSwichView()
            Spacer()
            taskTextFieldView()
            Spacer()
            Spacer()
            taskAddButtonView()
            Spacer()
        }
    }
    
    /// タスクセクション選択用セグメントコントロール
    @ViewBuilder
    private func taskSectionSwichView() -> some View {
        
        Picker("taskSection", selection: $viewModel.selectedtaskSection) {
            ForEach(TaskAddViewModel.taskSections.allCases) {
                Text($0.rawValue).tag($0)
            }
        }
        .pickerStyle(.segmented)
        .padding()
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
            viewModel.handleAddButtonTap(taskSection: viewModel.selectedtaskSection.rawValue)
            isFocused = false
            dismiss()
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
