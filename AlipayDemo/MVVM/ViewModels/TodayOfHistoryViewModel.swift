//
//  SwiftUIView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/12/7.
//

import SwiftUI
import SwifterSwift

class TodayOfHistoryViewModel: ObservableObject {
    // 发布数据列表属性
    @Published var eventList: [HistoryEvent] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var userSeletedDate : Date = .now
    var dateP : String {
        "\(userSeletedDate.month)/\(userSeletedDate.day)"
    }
    func getData() {
        isLoading = true
        guard let url = URL(string: "http://v.juhe.cn/todayOnhistory/queryEvent.php?key=e1300567e653b2e517e66f609d006e42&date=\(dateP)") else {
            errorMessage = "URL写错了"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                withAnimation {
                    self?.isLoading = false
                }
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                if let data = data {
                    self?.parseHistoryData(jsonData: data)
                }
            }
        }.resume()
    }
    
    private func parseHistoryData(jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(HistoryResponse.self, from: jsonData)
            
            // 直接更新数据列表
            eventList = response.result
            errorMessage = nil
            
        } catch {
            errorMessage = "解析错误: \(error.localizedDescription)"
        }
    }
}
