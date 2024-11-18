//
//  WechatDemo.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/15.
//

import SwiftUI

struct WechatDemo: View {
    @Environment(\.dismiss) var dismiss
    
    struct Message {
        var text: String
        var isMine: Bool
        var isTrans: Bool = false
        var amount : Double = 299
        var isTime : Bool = false
        var timeStr : String = ""
    }
    
    var messages: [Message] = [Message(text: "咱们现在周末还有课吗？", isMine: false),
                               Message(text: "有的", isMine: true),
                               Message(text: "好的，299是吧，直接转给你么", isMine: false),
                               Message(text: "是的", isMine: true),
                               Message(text: "转账299", isMine: false, isTrans: true),
                               Message(text: "收款299", isMine: true, isTrans: true),
                               Message(text: "怎么看回放？", isMine: false),
                               Message(text: "入帐后发你", isMine: true)]
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            navigationBar
           
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    ForEach(messages, id: \.text) { message in
                        text(message)
                    }
                }
                .padding()
            }

            Spacer()
            Image("WechatBottomBar")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width)
//                .frame(height: 53)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(hex: "EDEDED"))
    }
    
    func text(_ message : Message) -> some View {
        HStack(alignment: .top,spacing:16){
            if message.isMine{
                Spacer()
            }else{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 44, height: 44, alignment: .center)
            }
            if message.isTrans{
                transMessage(message)
            }else{
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical,13)
                    .background(message.isMine ? Color(hex: "95EC69") : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .overlay(alignment: message.isMine ? .trailing : .leading) {
                        RoundedRectangle(cornerRadius: 3)
                            .frame(width: 10, height: 10, alignment: .center)
                            .foregroundColor(message.isMine ? Color(hex: "95EC69") : .white)
                            .rotationEffect(.degrees(45))
                            .offset(x: message.isMine ? 5 : -5)
                    }
            }
         
            if message.isMine{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 44, height: 44, alignment: .center)
            }else{
                Spacer()
                
            }
        }
    }
    
    func transMessage(_ message : Message) -> some View {
        
        VStack(alignment: .leading){
            Spacer()
            HStack{
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                VStack(alignment: .leading,spacing: 4){
                    Text("¥\(String.init(format: "%.2f", message.amount))")
                        .font(.subheadline)
                        .bold()
                    Text(message.isMine ?  "已收款" : "已被接受")
                        .font(.caption2)
                        .bold()
                }
                Spacer()
            }
            Rectangle().frame( height: 0.5, alignment: .center)
                .foregroundColor(.white)
                .opacity(0.3)
            Text("微信转账")
                .font(.caption2)
        }
        .padding(.bottom,6)
        .foregroundColor(.white)
        .padding(.horizontal)
        .frame(width: 234, height: 80, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 4)
            .foregroundColor(.init(hex: "FA9D3B")))
        .overlay(alignment: message.isMine ? .topTrailing : .topLeading) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 10, height: 10, alignment: .center)
                .foregroundColor(Color(hex: "FA9D3B"))
                .rotationEffect(.degrees(45))
                .offset(x: message.isMine ? 5 : -5)
                .padding(.top,13)
        }
        
        
            
    }
    
    var navigationBar: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .rotationEffect(.init(degrees: 90))
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.horizontal)
            .overlay {
                Text("某某某")
                    .font(Font.title3)
                    .bold()
            }
            Rectangle()
                .foregroundColor(Color(hex: "D5D5D5"))
                .frame(height: 1)
        }
        .padding(.top, 12)
    }
}

#Preview {
    WechatDemo()
}
