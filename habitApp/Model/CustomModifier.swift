//
//  Modifier.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/07.
//

import SwiftUI

//カスタムモディファイア
struct CustomModifier: ViewModifier {
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
