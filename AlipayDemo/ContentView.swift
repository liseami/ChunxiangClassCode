//
//  ContentView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/11.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var currentTabbar: TabbarType = .system
    enum TabbarType : String, CaseIterable {
        case system = "主页"
        case demo = "模拟器"
        case profile = "我的"
    }
}

struct ContentView: View {
    @StateObject var vm: MainViewModel = .init()
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                Text("纯想百宝箱")
                    .font(.largeTitle)

                switch vm.currentTabbar {
                case .system:
                    SystemUIView()
                case .demo:
                    DemosView()
                case .profile:
                    Text("个人主页")
                }

                Spacer()
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
    }
}

#Preview {
    ContentView()
}
