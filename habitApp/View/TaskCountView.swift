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
    // 対象タスク
    @State var taskData: TaskData
    // タスク情報管理メソッド
    @EnvironmentObject private var taskDataManager: TaskDataManager
    //　キャラクター情報管理メソッド
    @EnvironmentObject private var characterDataManager: CharacterDataManager
    
    @Environment(\.dismiss) private var dismiss
    // 今日の日付(時間は0時0分0秒0コンマ秒を指定)
    private let now = Date().zeroclock
    
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
            if taskData.lastDoneDate == now && taskData.continationCount != 0 {
                buttonEnable = false
            }
        }
        .toolbar(content: toolbarContent)
    }
    
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        // ナビゲーションの右側にDeleteボタンを配置
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                Task {
                    await taskDelete()
                }
            } label: {
                Text("delete")
            }
        }
    }
    
    /// 画面.タスク名
    @ViewBuilder
    private func taskNameView() -> some View {
        Text(taskData.taskName)
    }
    
    /// 画面.継続回数
    @ViewBuilder
    private func taskCountView() -> some View {
        Text("\(taskData.continationCount)")
    }
    
    /// 画面.タスクカウントボタン
    @ViewBuilder
    private func taskCountButtonView() -> some View {
        // タスク完了ボタン
        Button {
            Task {
                await taskDone()
            }
        } label: {
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
    private func taskDone() async {
        // 対象のタスクの継続回数に1を足す
        taskData.continationCount += 1
        await taskDataManager.doneTask(taskData: taskData) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("TaskData update successfully.")
            }
        }
        if let characterData = characterDataManager.characterDataArray.first(where: {$0.id == "kumaneko0001"}) {
            // 対象キャラクターの総保有経験値に1を足す
            await characterDataManager.getExperiencePoint(characterData: characterData) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("CharacterData update successfully.")
                }
            }
        }
        // タスク完了ボタンを非活性
        buttonEnable.toggle()
    }
    
    /// タスク削除時の処理
    private func taskDelete() async {
        // 遷移元に戻る
        dismiss()
        await taskDataManager.deleteTask(taskData: taskData) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("taskData delete successfully.")
            }
        }
    }
}


