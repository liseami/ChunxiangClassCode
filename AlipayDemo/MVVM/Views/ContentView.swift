//
//  ContentView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/11.
//

import SwiftUI
import Toasts

class TostaUIViewModel: ObservableObject {
    
    /// 全局唯一，静态单例
    static let shared : TostaUIViewModel = .init()
    @Published var showBottomTosta: Bool = false

    func showTosta() {
        withAnimation {
            showBottomTosta = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showBottomTosta = false
            }
        }
    }
}

struct ContentView: View {
    @StateObject var vm: MainViewModel = .init()
    @ObservedObject var tostaVM : TostaUIViewModel = .shared
    @Environment(\.presentToast) var presentToast
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                Text("纯想百宝箱")
                    .font(.largeTitle)
                    .onTapGesture {
                        let toast = ToastValue(
                            icon: Image(systemName: "pencil.circle.fill"),
                            message: "你有一条新的通知。"
                          )
                          presentToast(toast)
                    }

                switch vm.currentTabbar {
                case .system:
                    SystemUIView()
                case .demo:
                    DemosView()
                        
                case .profile:
                    Text("个人主页")
                }

                Spacer()

                TabbarView()
                    .environmentObject(vm)
            }
        }
        .overlay(alignment: .bottom) {
            if tostaVM.showBottomTosta {
                Text("我是一条通知")
                    .foregroundColor(.white)
                    .padding(.all)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .transition(.scale.combined(with: .opacity).combined(with: .move(edge: .bottom)))
            }
        }
    }
}

#Preview {
    ContentView()
}
