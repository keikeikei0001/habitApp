//
//  TaskData.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/04.
//
import Foundation

/// タスク情報
struct TaskData: Identifiable {
    /// タスクID
    var id: String
    /// タスク名
    var taskName: String
    /// 継続回数
    var continationCount: Int
    /// 最終完了日
    var lastDoneDate: Date
    /// 作成日
    var createDate: Date 
}
