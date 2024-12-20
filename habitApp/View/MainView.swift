//
//  MainView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                chracterView()
                taskButtonView()
            }
            .padding()
            .onAppear(perform: viewModel.handleOnAppear)
        }
    }
    
    /// キャラクターView
    @ViewBuilder
    private func chracterView() -> some View {
        // TODO: - 後々、現在使用中のキャラクターを引数にするようにして、キャラを切り替えられるようにする。
        if let characterData = viewModel.characterDataArray.first(where: { $0.id == "kumaneko0001"}) {
            VStack {
                HStack {
                    Spacer()
                    Text(characterData.name)
                    Spacer()
                    VStack {
                        Text("Lv.\(characterData.levelInfo.0)")
                        Text("\(characterData.levelInfo.1)  /  \(characterData.levelInfo.2)")
                            .font(.system(size: 20))
                    }
                    Spacer()
                }
                .font(.title)
                Image(characterData.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: DeviceModel.width/2)
            }
            .frame(maxHeight: .infinity)
        } else {
            ProgressView()
        }
    }
    
    /// タスクボタンView
    @ViewBuilder
    private func taskButtonView() -> some View {
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
