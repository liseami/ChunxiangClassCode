//
//  WechatDemo.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/15.
//

import SwiftUI

func avatarView(_ uiimage: UIImage?) -> some View {
    Group {
        if uiimage != nil {
            Image(uiImage: uiimage!)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.gray.opacity(0.6))
                .frame(width: 44, height: 44)
        }
    }
}

struct WechatDemo: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: WechatDemoViewModel = .init()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            /// 顶部标题栏
            navigationBar
            /// 消息滚动列表
            messageList
            /// 虚假的微信底部模拟仿真图片
            fakeWechatBottomImage
        }
        .fullScreenCover(isPresented: $vm.showEditView, content: {
            MessagesEditView()
                .environmentObject(vm)
        })
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color(hex: "EDEDED"))
    }
    
    var fakeWechatBottomImage: some View {
        Image("WechatBottomBar")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: UIScreen.main.bounds.width)
    }
    
    var messageList: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                ForEach(vm.messages) { message in
                    switch message.type {
                    case .text, .transfer:
                        messageView(message)
                    case .timestamp(let str):
                        Text(str)
                            .opacity(0.22437)
                    default: EmptyView()
                    }
                }
            }
            .padding()
        }
    }
    
    func messageView(_ message: Message) -> some View {
        HStack(alignment: .top, spacing: 16) {
            if message.isMine {
                Spacer()
            } else {
                avatarView(vm.avatar2)
            }
            
            switch message.type {
            case .text(let text):
                textMessageView(text, isMine: message.isMine)
            case .transfer(let amount):
                transferMessageView(amount: amount, isMine: message.isMine)
            default:
                EmptyView()
            }
            
            if message.isMine {
                avatarView(vm.avatar1)
            } else {
                Spacer()
            }
        }
    }
    
    func textMessageView(_ text: String, isMine: Bool) -> some View {
        Text(text)
            .padding(.horizontal)
            .padding(.vertical, 13)
            .background(isMine ? Color(hex: "95EC69") : .white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: isMine ? .trailing : .leading) {
                messageTriangle(color: isMine ? Color(hex: "95EC69") : .white, isMine: isMine)
            }
    }
    
    func transferMessageView(amount: Double, isMine: Bool) -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    Text("¥\(String(format: "%.2f", amount))")
                        .font(.subheadline)
                        .bold()
                    Text(isMine ? "已收款" : "已被接受")
                        .font(.caption2)
                        .bold()
                }
                Spacer()
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.2))
            Text("微信转账")
                .font(.caption2)
        }
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
    
    func messageTriangle(color: Color, isMine: Bool) -> some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 10, height: 10)
            .foregroundColor(color)
            .rotationEffect(.degrees(45))
            .offset(x: isMine ? 5 : -5)
    }
    
    var navigationBar: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .rotationEffect(.degrees(90))
                }
                
                Spacer()
                
                Button(action: { vm.showEditView = true }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal)
            .overlay {
                Text("某某某")
                    .font(.title3)
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
