//
//  StartUpView.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/12.
//
import SwiftUI

struct StartUpView: View {
    let characters: Array<String.Element> = Array("Life is RPG")
    
    @State var offsetYForBounce: CGFloat = -50
    @State var opacity: CGFloat = 0
    @State var baseTime: Double = 0.0
    
    var body: some View {
        VStack {
            BounceAnimationView()
                .padding(.top, 30)
        }
    }
    /// 画面.タスク名
    @ViewBuilder
    private func BounceAnimationView() -> some View {
        
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(characters[num]))
                    .font(.custom("HiraMinProN-W3", fixedSize: 24))
                    .offset(x: 0, y: offsetYForBounce)
                    .opacity(opacity)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay( Double(num) * 0.1 ), value: offsetYForBounce)
            }
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    opacity = 0
                    offsetYForBounce = -50
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + (0.8 + baseTime)) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
        }
    }
}

