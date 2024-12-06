//
//  Message.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/6.
//

import SwiftUI

// 优化后的消息类型枚举
enum MessageType {
    case text(String)
    case transfer(amount: Double)
    case timestamp(String)
    case video
    case photo
    case url
    case muisc
    
    // 添加一个计算属性来获取消息内容
    var content: String {
        switch self {
        case .text(let str): return str
        case .transfer(let amount): return String(format: "%.2f", amount)
        case .timestamp(let str): return str
        default: return ""
        }
    }
}

// 优化后的消息结构体
struct Message: Identifiable {
    let id = UUID()
    let type: MessageType
    let isMine: Bool
}
