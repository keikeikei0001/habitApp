//
//  SwiftUIView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/04.
//
import Foundation

//タスク情報
struct TaskData: Codable {
    var taskId = UUID()
    var taskTitle: String
    var continationCount: Int = 0
}
