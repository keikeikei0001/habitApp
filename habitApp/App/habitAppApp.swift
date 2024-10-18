//
//  habitAppApp.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

@main
struct habitAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(TaskDataManager())
                .environmentObject(CharacterDataManager())
        }
    }
}
