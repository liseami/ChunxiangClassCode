//
//  Ex.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/15.
//

import SwiftUI

extension Date {
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
}

extension Color {
    /// 使用十六进制字符串初始化 Color
    /// - Parameter hex: 十六进制颜色字符串，支持 "FFFFFF" 或 "#FFFFFF" 格式
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        
        switch hex.count {
        case 3: // RGB (12-bit)
            r = Double((int >> 8) & 0xF) / 15.0
            g = Double((int >> 4) & 0xF) / 15.0
            b = Double(int & 0xF) / 15.0
        case 6: // RGB (24-bit)
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        default:
            r = 0
            g = 0
            b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
    
    // 常用颜色静态属性
    static let background = Color(hex: "EDEDED")
    static let customGray = Color(hex: "#EDEDED") // 带 # 也可以
}
