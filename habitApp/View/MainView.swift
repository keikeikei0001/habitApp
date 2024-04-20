//
//  MainView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct MainView: View {
    
    // キャラクター情報管理クラス
    @EnvironmentObject private var characterDataManager: CharacterDataManager
    // タスク情報管理クラス
    @EnvironmentObject private var taskDataManager: TaskDataManager
    // 起動時ロードフラグ
    @State private var isLoading = true
    
    private let us = UserDefaults.standard
    
    var body: some View {
        
        if isLoading {
            // 画面起動時に呼ばれる
            // StartUpViewに遷移
            StartUpView().onAppear {
                Task {
                    // ユーザーID、キャラクター情報、タスク情報を取得
                    await dataGet()
                    // キャラクター情報がない場合は、キャラクター情報を新規で作成する
                    await characterCreate()
                }
                // 画面が起動してから2.3秒後に[isLoading = false]を代入
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            NavigationStack {
                VStack {
                    Spacer()
                    // キャラクター部分
                    chracterView()
                    Spacer()
                    // ボタン部分
                    taskButtonView()
                    Spacer()
                }
                .padding()
                .onAppear {
                    Task {
                        await taskDataManager.fetchTask()
                        await characterDataManager.fetchCharacter()
                    }
                }
            }
        }
    }
    
    /// キャラクター部分
    @ViewBuilder
    private func chracterView() -> some View {
        // 後々、現在使用中のキャラクターを引数にするようにして、キャラを切り替えられるようにする。
        if let characterData = characterDataManager.characterDataArray.first(where: { $0.id == "kumaneko0001"}) {
            VStack {
                HStack {
                    // キャラ名
                    Text(characterData.name)
                    // キャラクターのレベル
                    Text("Lv.\(levelSet(allExperiencePoint: characterData.allExperiencePoint))")
                }
                .font(.title)
                // キャラクター画像
                Image(characterData.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: DeviceModel.width/2)
            }
        }
    }
    
    /// タスクボタン部分
    @ViewBuilder
    private func taskButtonView() -> some View {
        // タスク画面遷移ボタン
        NavigationLink(destination: TaskListView()) {
            Text("Task")
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.title)
                .cornerRadius(10)
        }
    }
    
    /// 情報取得メソッド
    private func dataGet() async {
        // ユーザーIDを取得する
        let userId = us.string(forKey: "userId") ?? ""
        
        if userId == "" {
            us.set("\(UUID())", forKey: "userId")
        }
        // キャラクター情報取得
        await characterDataManager.fetchCharacter()
        // タスク情報取得
        await taskDataManager.fetchTask()
    }
    
    /// キャラクター情報新規作成
    private func characterCreate() async {
        if characterDataManager.characterDataArray.count == 0 {
            await characterDataManager.saveCharacter(id: "kumaneko0001", name: "安倍　晋三") { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Character create successfully.")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
