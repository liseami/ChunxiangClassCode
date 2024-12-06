//
//  ViewModifiers.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/6.
//

import SwiftUI

struct MessageText : ViewModifier{
    let isMine : Bool
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 13)
            .background(isMine ? Color(hex: "95EC69") : .white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: isMine ? .trailing : .leading) {
                messageTriangle(color: isMine ? Color(hex: "95EC69") : .white, isMine: isMine)
            }
    }
}

extension View {
    func isMessageText(isMine : Bool) -> some View{
        return  self.modifier(MessageText(isMine: isMine))
    }
    
    func isTransMessage(isMine : Bool) -> some View {
        return self.modifier(TransMessage(isMine: isMine))
    }
}


struct TransMessage : ViewModifier{
    let isMine : Bool
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 6)
            .foregroundColor(.white)
            .padding(.horizontal)
            .frame(width: 234, height: 80)
            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "FDE1C3")))
            .overlay(alignment: isMine ? .topTrailing : .topLeading) {
                messageTriangle(color: Color(hex: "FDE1C3"), isMine: isMine)
                    .padding(.top, 13)
            }
    }
}

public func messageTriangle(color: Color, isMine: Bool) -> some View {
    RoundedRectangle(cornerRadius: 3)
        .frame(width: 10, height: 10)
        .foregroundColor(color)
        .rotationEffect(.degrees(45))
        .offset(x: isMine ? 5 : -5)
}


