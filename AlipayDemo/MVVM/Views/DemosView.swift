//
//  DemosView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/24.
//

import SwiftUI

struct DemosView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            NavigationLink("支付宝付款记录生成器") {
                AlipayDemoView()
                    .navigationBarBackButtonHidden()
            }
            NavigationLink("微信聊天记录生成器") {
                WechatDemo()
                    .navigationBarBackButtonHidden()
            }
            NavigationLink("历史上的今天") {
                TodayOfHistory()
                    .navigationBarBackButtonHidden()
            }
            NavigationLink("BMI计算器") {
                TodayOfHistory()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    NavigationView {
        DemosView()
    }
}
