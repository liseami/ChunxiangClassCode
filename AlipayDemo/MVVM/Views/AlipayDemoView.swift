//
//  AlipayDemoView.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/15.
//

import SwiftUI

struct AlipayDemoView: View {

    @Environment(\.dismiss) var dismiss
    @State var amount : Float = 0.0
    @State var amountIntput : String = "1000.00"
    @State var nameInput : String = "**巧（个人）"
    @State var toggleBool : Bool = true
    @State var isOpenSheet : Bool = false
    @State var date : Date = .now
    @State var showMore = false
    
    var body: some View {
        
        ZStack {
            // 背景色
            backGroundColor()
            VStack {
                // 标题栏
                navigationBar
                    .padding(.bottom)
                Group{
                    // 卡片1
                    card_1
                    // 当我点击卡片时
                        .onTapGesture {
                            amount =  amount + 100
                        }
                    // 卡片2
                    card_2
                    
                }
                .offset(y:24)
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isOpenSheet) {
            InputView(amountIntput: $amountIntput, nameInput: $nameInput, isOpenSheet: $isOpenSheet, date: $date)
        }
    }
    
    
    
    
    
    
    

    // 金额Text
    var amontText : some View {

        Text(String(format: "%.2f", Float(amountIntput) ?? 0.3))
            .font(.custom("Alibaba Sans Medium", size: 44))
            .bold()
            .foregroundColor(Color("AlifontBlack"))
            .onTapGesture {
                isOpenSheet = true
            }
    }
    
    
    func backGroundColor() -> some View {
        Color(String("AlipayGray"))
            .ignoresSafeArea()
    }
    
    var navigationBar: some View {
        HStack {
            Image(systemName: "chevron.down")
                .font(.title2)
                .foregroundStyle(.black)
                .rotationEffect(.init(degrees: 90))
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Text("全部账单")
        }
        .overlay {
            Text("账单详情")
                .font(Font.title3)
                .bold()
        }
    }
    
    var card_1: some View {
        let title1 = "支付时间"
        let title2 = "付款方式"
        
        return VStack(alignment: .center, spacing: CGFloat(32)) {
            VStack(alignment: .center, spacing: -2) {
                // - 1
                Text("笑")
                // 金额
                amontText
                Text("交易成功")
                    .foregroundColor(Color("AlifontBlack"))
            }
        
            // **************************
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Text(title1)
                        .foregroundStyle(.secondary)
                        .frame(width: 100, alignment: Alignment.leading)
                    Text(date.dateString)
                    Spacer()
                }
                HStack {
                    Text(title2)
                        .foregroundStyle(.secondary)
                        .frame(width: 100, alignment: Alignment.leading)
                    Text("余额宝")
                    Spacer()
                }
                
                HStack {
                    Text("商品说明")
                        .foregroundStyle(.secondary)
                        .frame(width: 100, alignment: Alignment.leading)
                    Text("收钱码收款")
                    Spacer()
                }
                HStack {
                    Text("收款方全称")
                        .foregroundStyle(.secondary)
                        .frame(width: 100, alignment: Alignment.leading)
                    TextField("输入收款方全称", text: $nameInput)
                    Spacer()
                }
                
                if showMore {
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 80, height: 80, alignment: .center)
                        .transition(.scale(scale: 3).combined(with: .opacity))
                }
                
                Button {
                    withAnimation {
                        showMore.toggle()
                    }
                } label: {
                    HStack {
                        Text(showMore ? "收起" : "更多")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .rotationEffect(.degrees( showMore ? -180 : 0))
                    }
                }
                
             
            }
            .foregroundColor(Color("AlifontBlack"))
            
            // **************************
        }
        .padding()
        .padding(.top)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(alignment: .top) {
            Image("AlipayDemoTopImage")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .offset(x: 0, y: -20)
        }
    }
    
    var card_2: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text("账单管理")
                    .bold()
                    .font(.title3)
                Spacer()
            }
               
            HStack {
                Text("账单分类")
                Spacer()
                Text("生活服务")
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.down")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .rotationEffect(.init(degrees: -90))
            }
            HStack {
                Text("标签和备注")
                Spacer()
                Text("添加")
                    .foregroundStyle(.secondary)
                Image(systemName: "chevron.down")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .rotationEffect(.init(degrees: -90))
            }
            HStack {
                Text("计入收支")
                Toggle(isOn:$toggleBool) {}
                    .tint(Color("AlipayToggle"))
                    .scaleEffect(0.733, anchor: .trailing)
            }
               
            Divider()
            // **************************
               
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    blueRow(iamgeName: "phone", text: "联系收款方")
                    Spacer()
                    blueRow(iamgeName: "ali_search", text: "查看往来记录")
                           
                    Spacer()
                }
                   
                HStack {
                    blueRow(iamgeName: "aa", text: "AA收款")
                           
                    Spacer()
                    blueRow(iamgeName: "tag", text: "往来流水证明")
                           
                    Spacer()
                }
                HStack {
                    blueRow(iamgeName: "message", text: "申请电子回单")
                           
                    Spacer()
                    blueRow(iamgeName: "q", text: "对此订单有疑问")
                           
                    Spacer()
                }
            }
            .foregroundColor(Color("AlipayBlue"))
        }
        .foregroundColor(Color("AlifontBlack"))
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
    
    func blueRow(iamgeName : String,text:String) -> some View {
        HStack(alignment: .center, spacing: 8) {
            Image(iamgeName)
                .resizable()
                .frame(width: 22, height: 22, alignment: .center)
            Text(text)
        }
        .frame(width:UIScreen.main.bounds.width / 2 - 48,alignment: .leading)
    }
    
}

#Preview {
    AlipayDemoView()
}
