//
//  TaskCountView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

struct TaskCountView: View {
    @StateObject var viewModel: TaskCountViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            taskNameView()
            Spacer()
            taskCountView()
            Spacer()
            taskCountButtonView()
            Spacer()
        }
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        // ナビゲーションの右側にDeleteボタンを配置
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.handleDeleteButtonTap()
                dismiss()
            } label: {
                Text("delete")
            }
        }
    }
    
    /// 画面.タスク名
    @ViewBuilder
    private func taskNameView() -> some View {
        Text(viewModel.taskData.taskName)
    }
    
    /// 画面.継続回数
    @ViewBuilder
    private func taskCountView() -> some View {
        Text("\(viewModel.taskData.continationCount)")
    }
    
    /// 画面.タスクカウントボタン
    @ViewBuilder
    private func taskCountButtonView() -> some View {
        // タスク完了ボタン
        Button(action: viewModel.handleTaskCountButtonTap) {
            Text("Done")
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(viewModel.enableTaskCountButton ? .gray :.blue)
                .foregroundStyle(.white)
                .font(.title)
                .cornerRadius(10)
        }
        .disabled(viewModel.enableTaskCountButton)
    }
}



