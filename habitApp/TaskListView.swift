//
//  TaskListView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct TaskListView: View {
    let taskData = [TaskData(taskTitle: "ランニング", continationCount: 5), TaskData(taskTitle: "筋トレ", continationCount: 13), TaskData(taskTitle: "昼寝", continationCount: 4)]
    
    var body: some View {
        List(0..<taskData.count, id:\.self) { index in
            HStack {
                Text(taskData[index].taskTitle)
                Spacer()
                Text("\(taskData[index].continationCount)")
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
