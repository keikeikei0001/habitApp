//
//  ContentView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

//メイン画面
struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                //ヘッダー
                ContentHeader()
                    .padding()
                Spacer()
                //メイン
                ContentMain()
                Spacer()
                //フッター
                ContentFooter()
            }
            .padding()
        }
    }
}

//メイン画面ヘッダー部分
struct ContentHeader: View {
    var level = 1
    var body: some View{
        HStack {
            //キャラ名
            Text("クマネコ")
                .font(.system(size: 25))
                .padding()
            Spacer()
                .frame(width: 110)
            //キャラクターのレベル
            Text("Lv." + String(level))
                .font(.system(size: 25))
                .padding()
        }
    }
}

//メイン画面のメイン部分
struct ContentMain: View {
    var body: some View{
        //キャラクター画像
        Image("kumaneko")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width/2)
    }
}

//メイン画面のフッターの部分
struct ContentFooter: View {
    let taskManager = TaskManager()
    @EnvironmentObject var taskObject: TaskObject
    var body: some View{
            //タスク画面遷移ボタン
            Button {
            } label: {
                NavigationLink(destination: TaskListView().navigationTitle("Task")){
                    Text("Task")
                        .modifier(CustomModifier(color: .blue))
                        .padding()
                        .onAppear(){
                            //タスク情報を取得し、taskObjectに渡す
                            taskObject.taskData = taskManager.loadTask(forKey: "taskData") ?? []
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
