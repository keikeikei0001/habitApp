//
//  TaskAddView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

struct TaskAddView: View {
    // モーダル遷移フラグ
    @Binding var isTaskAddView: Bool
    // テキストフィールドの入力値
    @State private var inputTaskName = ""
    // テキストフィールドにフォーカスの有無
    @FocusState private var isFocused: Bool
    // タスク情報管理クラス
    @EnvironmentObject private var taskDataManager: TaskDataManager
    
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
        TextField("タスク名を入力してください", text: $inputTaskName)
            .textFieldStyle(.roundedBorder)
            .padding()
            .focused($isFocused)
    }
    
    /// タスク追加ボタン
    @ViewBuilder
    private func taskAddButtonView() -> some View {
        Button {
            Task {
                await taskAdd()
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
    
    /// タスク追加ボタン押下時
    private func taskAdd() async {
        // テキストフィールドへのフォーカス解除
        isFocused = false
        // タスク追加処理
        await taskDataManager.savetask(taskName: inputTaskName) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("TaskData add successfully.")
            }
        }
        // モーダル遷移を閉じる
        isTaskAddView = false
    }
}
