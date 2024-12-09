//
//  CustomButton.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/8.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    let action: (String) -> Void
    
    init(text: String = "按钮", action: @escaping (String) -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button.init {
            action("我是一个按钮")
        } label: {
            Text(text)
                .foregroundColor(.white)
                .frame(height: 44)
                .frame(width: 300)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    CustomButton(text: "按钮") { _ in
    }
}
