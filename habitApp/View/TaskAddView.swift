//
//  TaskAddView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

//タスク追加画面
struct TaskAddView: View {
    //モーダル遷移フラグ
    @Binding var isTaskAddView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            TaskAddMain(isTaskAddView: $isTaskAddView)
            Spacer()
        }
    }
}

//画面のメイン部分
struct TaskAddMain: View {
    //テキストフィールドの入力値
    @State var inputTaskName = ""
    //モーダル遷移フラグ
    @Binding var isTaskAddView: Bool
    //テキストフィールドにフォーカスの有無
    @FocusState var isFocused: Bool
    //タスク情報
    @EnvironmentObject var taskObject: TaskObject
    //タスク管理クラス
    let taskManager = TaskManager()
    
    var body: some View {
        VStack {
            //画面.タスク入力テキストフィールド
            TextField("タスク名を入力してください", text: $inputTaskName)
                .textFieldStyle(.roundedBorder)
                .padding()
                .focused($isFocused)
            Spacer()
            Button {
                //タスク追加ボタン押下時メソッド
                taskAdd()
            }label: {
                Text("Create")
                    .modifier(CustomModifier(color: .blue))
            }
        }
    }
    
    //タスク追加ボタン押下時
    func taskAdd() {
        //テキストフィールドへのフォーカス解除
        isFocused = false
        //タスク情報取得
        var todoArray = taskManager.loadTask(forKey: "taskData") ?? []
        //新しいタスクを追加し、保存
        let taskData = TaskData(taskName: inputTaskName)
        todoArray.append(taskData)
        taskManager.saveTask(taskArray: todoArray, forKey: "taskData")
        //追加されたタスク情報を画面に描画
        taskObject.taskData = taskManager.loadTask(forKey: "taskData") ?? []
        //モーダル遷移を閉じる
        isTaskAddView = false
    }
}
