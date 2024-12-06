//
//  TabbarView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/6.
//

import SwiftUI

struct TabbarView : View {
    @EnvironmentObject var vm : MainViewModel
    var body: some View {
        HStack {
            ForEach(MainViewModel.TabbarType.allCases,id: \.hashValue) { tab in
                let imSelected : Bool = (tab == vm.currentTabbar)
                Text(String(tab.rawValue))
                    .bold(imSelected)
                    .foregroundStyle(imSelected ? Color.blue : Color.black)
                    .frame(maxWidth:.infinity)
                    .padding(.vertical,6)
                    .overlay(content: {
                        if imSelected{
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .transition(.scale)
                        }else{
                            EmptyView()
                        }
                        
                    })
                    .onTapGesture {
                        vm.currentTabbar = tab
                }
            }
//                    Text("模拟器").onTapGesture {
//                        vm.currentTabbar = .demo
//                    }
//                    Text("我的").onTapGesture {
//                        vm.currentTabbar = .profile
//                    }
        }
        .animation(.smooth, value: vm.currentTabbar)
        .padding(.horizontal)
    }
}

#Preview {
    TabbarView()
        .environmentObject(MainViewModel.init())
}
