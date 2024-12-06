//
//  AlipayDemoApp.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/11.
//

import SwiftUI
import Toasts

@main
struct AlipayDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .installToast(position: .top)
        }
    }
}
