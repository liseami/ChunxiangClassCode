//
//  MainViewModel.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/6.
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
