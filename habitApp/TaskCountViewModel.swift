//
//  TaskCountView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/05/07.
//

import SwiftUI

class TaskCountViewModel: ObservableObject {
    @Published var buttonEnable: Bool = true

    private let taskDataManager: TaskDataManager = TaskDataManager()
    private let characterDataManager: CharacterDataManager = CharacterDataManager()
    let now = Date().zeroclock
}
