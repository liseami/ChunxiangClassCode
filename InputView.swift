//
//  AmontInputView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/13.
//

import SwiftUI

struct InputView: View {
    
    @Binding var  amountIntput : String
    @Binding var  nameInput : String
    @Binding var  isOpenSheet : Bool
    @Binding var date : Date
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("请输入你想要的金额")
            TextField("输入金额", text: $amountIntput)
                .multilineTextAlignment(.center)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
            Text("请输入你想要的名字")
            TextField("输入名字", text: $nameInput)
                .multilineTextAlignment(.center)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("日期选择", selection: $date, displayedComponents: .date)
            DatePicker("日期选择", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
            Spacer()
            Button {
                // 关闭这个sheet
                isOpenSheet = false
            } label: {
                Text("确认")
            }
            .buttonStyle(.bordered)

        }
        .padding()
    
        
        
    }
}

#Preview {
    InputView(amountIntput: .constant("1000.00"), nameInput: .constant("金巧巧"), isOpenSheet: .constant(true),date: .constant(.now))
}
