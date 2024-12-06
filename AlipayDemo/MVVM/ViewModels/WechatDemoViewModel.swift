//
//  WechatDemoViewModel.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/6.
//

import SwiftUI

// 可被观察的对象
class WechatDemoViewModel : ObservableObject{
    @Published var showEditView  : Bool = false
    @Published var avatar1 : UIImage?
    @Published var avatar2 : UIImage?
    // 使用优化后的数据结构重构消息数组
    @Published var messages: [Message] = [
        Message(type: .text("咱们现在周末还有课吗？"), isMine: false),
        Message(type: .timestamp("2月15日 10:15"), isMine: true),
        Message(type: .text("有的"), isMine: true),
        Message(type: .text("好的，299是吧，直接转给你么"), isMine: false),
        Message(type: .text("是的"), isMine: true),
        Message(type: .transfer(amount: 299), isMine: false),
        Message(type: .transfer(amount: 299), isMine: true),
        Message(type: .text("怎么看回放？"), isMine: false),
        Message(type: .text("入帐后发你"), isMine: true)
    ]
    
    @Published var userTextMessageInput: String = ""
    @Published var userTransMessageInput: String = ""
    @Published var userTimeMessageInput: String = ""
    @Published var showPicker1: Bool = false
    @Published var showPicker2: Bool = false
    @Published var addMessageForMe: Bool = true
    @Published var addMessageType: String = "text"



    
}
