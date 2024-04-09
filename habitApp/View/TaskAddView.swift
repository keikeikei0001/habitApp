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
    @State var inputTaskName = ""
    // テキストフィールドにフォーカスの有無
    @FocusState var isFocused: Bool
    // タスク情報
    @EnvironmentObject var taskObject: TaskObject
    // タスク管理クラス
    private let taskManager = TaskManager()
    
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
    private func taskTextFieldView() ->some View {
        VStack {
            // 画面.タスク入力テキストフィールド
            TextField("タスク名を入力してください", text: $inputTaskName)
                .textFieldStyle(.roundedBorder)
                .padding()
                .focused($isFocused)
        }
    }
    /// タスク追加ボタン
    @ViewBuilder
    private func taskAddButtonView() ->some View {
        Button {
            // タスク追加ボタン押下時メソッド
            taskAdd()
        }label: {
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
    private func taskAdd() {
        // テキストフィールドへのフォーカス解除
        isFocused = false
        // タスク情報取得
        var todoArray = taskManager.loadTask(forKey: "taskData") ?? []
        // 新しいタスクを追加し、保存
        let taskData = TaskData(taskName: inputTaskName)
        todoArray.append(taskData)
        taskManager.saveTask(taskArray: todoArray, forKey: "taskData")
        // 追加されたタスク情報を画面に描画
        taskObject.taskData = taskManager.loadTask(forKey: "taskData") ?? []
        // モーダル遷移を閉じる
        isTaskAddView = false
    }
}
