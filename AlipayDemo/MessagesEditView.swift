//
//  MessagesEditView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/23.
//

import ImagePickerSwiftUI
import SwiftUI

struct MessagesEditView: View {
    @Environment(\.dismiss) var dismiss
    @State var userTextMessageInput: String = ""
    @State var userTransMessageInput: String = ""
    @State var userTimeMessageInput: String = ""
    @State var showPicker1: Bool = false
    @State var showPicker2: Bool = false
    @State var addMessageForMe: Bool = true
    @State var addMessageType: String = "text"

    @Binding var avatar1: UIImage?
    @Binding var avatar2: UIImage?
    @Binding var messages: [Message]
    
    var body: some View {
        closeBtn
            .padding(.horizontal)
        List {
            avatarButtons
            messageAddView
            messageList
        }
        .listStyle(.plain)
    }

    var closeBtn: some View {
        HStack(alignment: .center, spacing: 12) {
            Button {
                dismiss()
            } label: {
                Text("关闭")
            }
            Spacer()
            Button {
                self.messages.removeAll()
            } label: {
                Text("清除")
            }
        }
    }

    var messageAddView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker(selection: $addMessageForMe) {
                Text("对方的消息").tag(false)
                Text("我的消息").tag(true)
            } label: {}
                .pickerStyle(.segmented)

//            Text(self.addMessageType)
            Picker(selection: $addMessageType) {
                Text("文字消息").tag("text")
                Text("转账消息").tag("trans")
                Text("时间消息").tag("time")
            } label: {}
                .pickerStyle(.segmented)

            switch self.addMessageType {
            case "text":
                TextField("输入你想添加的文字消息", text: $userTextMessageInput)
            case "trans":
                TextField("输入你想添加的转账金额", text: $userTransMessageInput)
                    .keyboardType(.numberPad)
            case "time":
                TextField("输入你想添加的时间", text: $userTimeMessageInput)
            default: EmptyView()
            }
            Button("添加一条消息") {
                if userTextMessageInput.isEmpty, userTransMessageInput.isEmpty, userTimeMessageInput.isEmpty {
                } else {
                    switch self.addMessageType {
                    case "text":
                        let new = Message(type: .text(self.userTextMessageInput), isMine: self.addMessageForMe)
                        self.messages.append(new)
                    case "trans":
                        let new = Message(type: .transfer(amount: Double(self.userTransMessageInput)!), isMine: self.addMessageForMe)
                        self.messages.append(new)
                    case "time":
                        let new = Message(type: .timestamp(self.userTimeMessageInput), isMine: self.addMessageForMe)
                        self.messages.append(new)
                    default: break
                    }

                    self.userTextMessageInput = ""
                }
            }
        }
        .padding(.all)
        .background(.secondary.opacity(0.1))
    }

    var messageList: some View {
        ForEach(self.messages, id: \.id) { message in
            Group{
                switch message.type {
                case .text(let str):
                    Text(str)
                        .frame(maxWidth: .infinity, alignment: message.isMine ? .trailing : .leading)
                case .transfer(let amount):
                    Text(String(amount))
                        .frame(maxWidth: .infinity, alignment: message.isMine ? .trailing : .leading)
                case .timestamp(let str):
                    Text(str)
                        .frame(maxWidth: .infinity, alignment: .center)
                default: EmptyView()
                }
            }
            .contextMenu {
                Button {
                    self.messages.removeAll { target in
                        target.id == message.id
                    }
                } label: {
                    Text("删除")
                }

            }

        }
    }

    var avatarButtons: some View {
        Group {
            Button {
                showPicker1 = true
            } label: {
                HStack(alignment: .center, spacing: 12) {
                    Text("我的头像")
                    Spacer()
                    avatarView(self.avatar1)
                }
            }
            .sheet(isPresented: $showPicker1) {
                ImagePickerSwiftUI(
                    selectedImage: $avatar1,
                    sourceType: .photoLibrary, // or .photoLibrary
                    allowsEditing: false
                )
            }

            Button(action: {
                showPicker2 = true
            }, label: {
                HStack(alignment: .center, spacing: 12) {
                    avatarView(self.avatar2)
                    Spacer()
                    Text("对方头像")
                }
            })
            .sheet(isPresented: $showPicker2) {
                ImagePickerSwiftUI(
                    selectedImage: $avatar2,
                    sourceType: .photoLibrary, // or .photoLibrary
                    allowsEditing: false
                )
            }
        }
    }

 
}

#Preview {
    WechatDemo()
}
