//
//  ImageDemo.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/13.
//

import SwiftUI

struct ImageDemo: View {
    var body: some View {
       
        VStack(alignment: .center, spacing: 80) {
            Image("Chunxiang")
                // 基础图片调整
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250, alignment: .center)
                .clipped()
                // 形状与边框效果
                .clipShape(Circle())
            Image(systemName: "bolt.heart.fill")
                // 基础图片调整
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
                .clipped()

        }
        
            
    }
}

#Preview {
    ImageDemo()
}
