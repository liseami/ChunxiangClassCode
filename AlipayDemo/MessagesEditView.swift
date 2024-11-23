//
//  MessagesEditView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/23.
//

import SwiftUI
import ImagePickerSwiftUI

struct MessagesEditView: View {
    @Environment(\.dismiss) var dismiss
    @State var showPicker1 : Bool =  false
    @State var showPicker2 : Bool =  false
    @Binding var avatar1 : UIImage?
    @State var avatar2 : UIImage? = nil
    var body: some View {
        List {
            
            Button {
                dismiss()
            } label: {
                Text("关闭")
            }

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
    
    func avatarView( _ uiimage : UIImage?) -> some View{
        Group{
            if uiimage != nil {
                  Image.init(uiImage: uiimage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(    RoundedRectangle(cornerRadius: 8))
            }else{
                  RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 44, height: 44)
            }
        }
    }
}

#Preview {
    MessagesEditView(avatar1: .constant(nil))
}
