//
//  MainView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            // 画面起動時に呼ばれる
            // StartUpViewに遷移
            StartUpView().onAppear {
                Task {
                    // ユーザーID、キャラクター情報、タスク情報を取得
                    await viewModel.dataGet()
                    // キャラクター情報がない場合は、キャラクター情報を新規で作成する
                    await viewModel.characterCreate()
                }
                // 画面が起動してから2.3秒後に[isLoading = false]を代入
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    withAnimation {
                        viewModel.isLoading = false
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
                        await viewModel.dataGet()
                    }
                }
            }
        }
    }
    
    /// キャラクター部分
    @ViewBuilder
    private func chracterView() -> some View {
        // 後々、現在使用中のキャラクターを引数にするようにして、キャラを切り替えられるようにする。
        if let characterData = viewModel.characterDataArray.first(where: { $0.id == "kumaneko0001"}) {
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
}
