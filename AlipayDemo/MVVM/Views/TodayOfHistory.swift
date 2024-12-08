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
        VStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 12) {
                DatePicker(selection: $vm.userSeletedDate, displayedComponents: .date) {
                    Text("选择日期")
                }
                .datePickerStyle(.compact)
                .padding(.trailing, 32)
                Spacer()
                Button {
                    vm.getData()
                } label: {
                    Text("获取数据")
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
//            row(.init(day: "12月17日", date: "1889年12月7日", title: "第一个充气轮胎受专利保护", e_id: "14883"))
            if vm.isLoading {
                ProgressView()
                    .frame(maxHeight: .infinity)
            } else {
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(vm.eventList) { event in
                            row(event)
                        }
                    }
                    .padding()
                }
                .transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
                .animation(.smooth, value: vm.isLoading)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "FBF6FA"))
    }

    func row(_ event: HistoryEvent) -> some View {
        HStack(alignment: .top, spacing: 20) {
            Text(event.date.prefix(4))
                .font(.callout)
                .foregroundStyle(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.3))
                .clipShape(Capsule())
            VStack(alignment: .leading, spacing: 12) {
                Text(event.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "timer")
                        .resizable()
                        .frame(width: 14, height: 14, alignment: .center)
                        .foregroundColor(.secondary)
                    Text(event.date)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TodayOfHistory()
}
