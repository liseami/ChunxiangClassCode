//
//  History.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/7.
//

// 顶层响应结构
struct HistoryResponse: Codable {
    let reason: String
    let result: [HistoryEvent]
    let error_code: Int
}

// 历史事件结构
struct HistoryEvent: Codable, Identifiable {
    let day: String
    let date: String
    let title: String
    let e_id: String
    
    // 符合 Identifiable 协议
    var id: String { e_id }
}
