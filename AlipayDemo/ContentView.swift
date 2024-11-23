//
//  ContentView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/11.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View{
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                Text("纯想百宝箱")
                    .font(.largeTitle)
                NavigationLink("系统控件一览") {
                    SystemUIView()
                }
                NavigationLink("支付宝付款记录生成器") {
                    AlipayDemoView()
                        .navigationBarBackButtonHidden()
                }
                NavigationLink("微信聊天记录生成器") {
                    WechatDemo()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }

}

#Preview {
    ContentView()
}

