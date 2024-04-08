//
//  ContentView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

//メイン画面
struct ContentView: View {
    //キャラクター情報管理クラス
    private let characterManager = CharacterManager()
    //タスク情報管理クラス
    private let taskManager = TaskManager()
    //キャクター情報
    @EnvironmentObject var characterObject: CharacterObject
    //タスク情報
    @EnvironmentObject var taskObject: TaskObject
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //キャラクター部分
                ChracterView()
                Spacer()
                //ボタン部分
                TaskButtonView()
                Spacer()
            }
            .padding()
            .onAppear(){
                //タスク情報を取得し、taskObjectに渡す
                characterObject.characterData = characterManager.loadTask(forKey: "characterData")
                //タスク情報を取得し、taskObjectに渡す
                taskObject.taskData = taskManager.loadTask(forKey: "taskData") ?? []
            }
        }
    }
    
    //キャラクター部分
    @ViewBuilder
    private func ChracterView() -> some View {
        VStack {
            HStack {
                //キャラ名
                Text("クマネコ")
                //キャラクターのレベル
                Text("Lv.\(levelSet(allExperiencePoint: characterObject.characterData.allExperiencePoint))")
            }
            .font(.title)
            //キャラクター画像
            Image("kumaneko")
                .resizable()
                .scaledToFit()
                .frame(width: DeviceModel.width/2)
        }
        
        
    }
    
    //タスクボタン部分
    @ViewBuilder
    private func TaskButtonView() -> some View {
        //タスク画面遷移ボタン
        NavigationLink(destination: TaskListView()){
            Text("Task")
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.title)
                .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
