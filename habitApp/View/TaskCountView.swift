//
//  TaskCountView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

struct TaskCountView: View {
    // ボタンの活性状態
    @State private var buttonEnable: Bool = true
    // タスク情報
    @EnvironmentObject private var taskObject: TaskObject
    // キャラクター情報
    @EnvironmentObject private var characterObject: CharacterObject
    
    @Environment(\.dismiss) private var dismiss
    // 対象タスクのindex
    let index: Int
    // 今日の日付(時間は0時0分0秒0コンマ秒を指定)
    private let now = Date().zeroclock
    // タスク情報管理メソッド
    private let taskManager = TaskManager()
    // キャラクター情報管理メソッド
    private let characterManager = CharacterManager()
    
    var body: some View {
        VStack {
            Spacer()
            // 画面.タスク名
            taskNameView()
            Spacer()
            // 画面.継続回数
            taskCountView()
            Spacer()
            // 画面.タスクカウントボタン
            taskCountButtonView()
            Spacer()
        }
        .onAppear {
            // タスクを1回でも行い、タスク情報.最終完了日が今日の場合、タスク完了ボタンを非活性にする
            if taskObject.taskData[index].lastDoneDate == now && taskObject.taskData[index].continationCount != 0 {
                buttonEnable = false
            }
        }
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        // ナビゲーションの右側にDeleteボタンを配置
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: taskDelete) {
                Text("delete")
            }
        }
    }
    
    /// 画面.タスク名
    @ViewBuilder
    private func taskNameView() -> some View {
        Text(taskObject.taskData[index].taskName)
    }
    
    /// 画面.継続回数
    @ViewBuilder
    private func taskCountView() -> some View {
        Text("\(taskObject.taskData[index].continationCount)")
    }
    
    /// 画面.タスクカウントボタン
    @ViewBuilder
    private func taskCountButtonView() -> some View {
        // タスク完了ボタン
        Button(action: taskDone) {
            Text("Done")
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(buttonEnable ? .blue :.gray)
                .foregroundStyle(.white)
                .font(.title)
                .cornerRadius(10)
        }
        .disabled(!buttonEnable)
    }
    
    /// タスク完了時の処理
    private func taskDone() {
        // タスク情報.継続回数に１を足す
        taskObject.taskData[index].continationCount += 1
        // タスク情報を保存する
        taskManager.saveTask(taskArray: taskObject.taskData, forKey: "taskData")
        // 総保有経験値に1を足す
        characterObject.characterData.allExperiencePoint += 1
        // キャラクター情報を保存する
        characterManager.saveTask(taskArray: characterObject.characterData, forKey: "characterData")
        // タスク完了ボタンを非活性
        buttonEnable.toggle()
    }
    
    /// タスク削除時の処理
    private func taskDelete() {
        // 遷移元に戻る
        dismiss()
        // 対象タスクを削除
        var task = taskManager.loadTask(forKey: "taskData") ?? []
        // 対象タスクを削除
        task.remove(at: index)
        // タスク情報を保存
        taskManager.saveTask(taskArray: task, forKey: "taskData")
    }
}


