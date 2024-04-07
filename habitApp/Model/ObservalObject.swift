//
//  ObservalObjectView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

class TaskObject: ObservableObject {
    @Published var taskData: [TaskData] = []
}

class CharacterObject: ObservableObject {
    @Published var characterData: CharacterData = CharacterData()
}
