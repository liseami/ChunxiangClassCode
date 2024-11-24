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
    @EnvironmentObject var vm :WechatDemoViewModel
    
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
                vm.messages.removeAll()
            } label: {
                Text("清除")
            }
        }
    }

    var messageAddView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker(selection: $vm.addMessageForMe) {
                Text("对方的消息").tag(false)
                Text("我的消息").tag(true)
            } label: {}
                .pickerStyle(.segmented)

//            Text(vm.addMessageType)
            Picker(selection: $vm.addMessageType) {
                Text("文字消息").tag("text")
                Text("转账消息").tag("trans")
                Text("时间消息").tag("time")
            } label: {}
                .pickerStyle(.segmented)

            switch vm.addMessageType {
            case "text":
                TextField("输入你想添加的文字消息", text: $vm.userTextMessageInput)
            case "trans":
                TextField("输入你想添加的转账金额", text: $vm.userTransMessageInput)
                    .keyboardType(.numberPad)
            case "time":
                TextField("输入你想添加的时间", text: $vm.userTimeMessageInput)
            default: EmptyView()
            }
            Button("添加一条消息") {
                if vm.userTextMessageInput.isEmpty, vm.userTransMessageInput.isEmpty, vm.userTimeMessageInput.isEmpty {
                } else {
                    switch vm.addMessageType {
                    case "text":
                        let new = Message(type: .text(vm.userTextMessageInput), isMine: vm.addMessageForMe)
                        vm.messages.append(new)
                    case "trans":
                        let new = Message(type: .transfer(amount: Double(vm.userTransMessageInput)!), isMine: vm.addMessageForMe)
                        vm.messages.append(new)
                    case "time":
                        let new = Message(type: .timestamp(vm.userTimeMessageInput), isMine: vm.addMessageForMe)
                        vm.messages.append(new)
                    default: break
                    }

                    vm.userTextMessageInput = ""
                }
            }
        }
        .padding(.all)
        .background(.secondary.opacity(0.1))
    }

    var messageList: some View {
        ForEach(vm.messages, id: \.id) { message in
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
                    vm.messages.removeAll { target in
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
                vm.showPicker1 = true
            } label: {
                HStack(alignment: .center, spacing: 12) {
                    Text("我的头像")
                    Spacer()
                    avatarView(vm.avatar1)
                }
            }
            .sheet(isPresented: $vm.showPicker1) {
                ImagePickerSwiftUI(
                    selectedImage: $vm.avatar1,
                    sourceType: .photoLibrary, // or .photoLibrary
                    allowsEditing: false
                )
            }

            Button(action: {
                vm.showPicker2 = true
            }, label: {
                HStack(alignment: .center, spacing: 12) {
                    avatarView(vm.avatar2)
                    Spacer()
                    Text("对方头像")
                }
            })
            .sheet(isPresented: $vm.showPicker2) {
                ImagePickerSwiftUI(
                    selectedImage: $vm.avatar2,
                    sourceType: .photoLibrary, // or .photoLibrary
                    allowsEditing: false
                )
            }
        }
    }

 
}

#Preview {
    WechatDemo()
        .environmentObject(WechatDemoViewModel.init())
}
