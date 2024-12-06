//
//  SystemUIView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/15.
//

import SwiftUI

struct SystemUIView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Text")
            Text("Text")
            
            Text("Image")
            Image("")
            
            Text("Divider")
            Divider()
            
            Text("Toggle")
            Toggle(isOn: .constant(true)) {
                
            }
            
            Text("ColorPicker")
            ColorPicker("颜色选择器", selection: .constant(.red))
        }
    }
}

#Preview {
    SystemUIView()
}
