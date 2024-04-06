//
//  ContentView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Header()
                    .padding()
                Spacer()
                Main()
                Spacer()
                Footer()
            }
            .padding()
        }
    }
}

struct Header: View {
    var level = 1
    var body: some View{
        HStack {
            Text("クマネコ")
                .padding()
            Spacer()
                .frame(width: 110)
            Text("Lv." + String(level))
                .padding()
        }
    }
}


struct Main: View {
    var body: some View{
        Image("kumaneko")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width/2)
    }
}

struct Footer: View {
    var body: some View{
            Button {
                
            } label: {
                NavigationLink(destination: TaskListView().navigationTitle("TASK")){
                    Text("TASK")
                        .modifier(ModifierCustom(color: .blue))
                    
                }
            }
    }
}
    
struct ModifierCustom: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width/2.3, height: 80)
                .background(color)
                .foregroundColor(.white)
                .font(.system(size: 25, design: .default))
                .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
