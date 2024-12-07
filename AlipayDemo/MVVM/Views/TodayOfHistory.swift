//
//  TodayOfHistory.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/7.
//

import SwiftUI



struct TodayOfHistory: View {
    @StateObject var vm: TodayOfHistoryViewModel = .init()
    var body: some View {
        Button {
            vm.getData()
        } label: {
            Text("获取数据")
        }
        
        if vm.isLoading {
            ProgressView()
        } else {
            List {
                ForEach(vm.eventList) { event in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(event.title)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(event.date)
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                    .padding(.all)
                    .background(Color.pink)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 12)
                }
            }
        }
    }
}

#Preview {
    TodayOfHistory()
}
