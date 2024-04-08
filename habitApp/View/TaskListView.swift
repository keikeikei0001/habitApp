//
//  TaskListView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

//タスクリスト画面
struct TaskListView: View {
    //タスク情報
    @EnvironmentObject var taskObject: TaskObject
    //モーダル遷移フラグ
    @State var isTaskAddView = false
    
    var body: some View {
        List {
            ForEach (Array(taskObject.taskData.enumerated()), id: \.element.taskId) { index, task in
                NavigationLink(destination: TaskCountView(index: index) ) {
                    //タスクテーブルセル
                    TaskTableCellView(index: index)
                }
            }
        }
        .toolbar {
            // ナビゲーションバーの右側に＋ボタンを配置
            // ボタン押下時、TaskAddViewに遷移する
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isTaskAddView = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isTaskAddView) {
                    TaskAddView( isTaskAddView: $isTaskAddView)
                }
            }
        }
    }
    
    //タスクのテーブルセル
    @ViewBuilder
    private func TaskTableCellView(index: Int) -> some View {
        HStack {
            //タスク情報.タスク名
            Text(taskObject.taskData[index].taskName)
            Spacer()
            //タスク情報.継続回数
            Text("\(taskObject.taskData[index].continationCount)")
        }
    }
}
