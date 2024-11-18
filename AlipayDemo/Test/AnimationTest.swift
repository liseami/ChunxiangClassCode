//
//  AnimationTest.swift
//  AlipayDemo
//
//  Created by 赵翔宇 on 2024/11/14.
//

import SwiftUI

// Bool ? 参数 ：参数

struct AnimationTest: View {
    @State var doIt : Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 29) {
            Spacer()
            Circle()
                .foregroundColor(doIt ? .yellow : .orange)
                .frame(width: doIt ? 100 : 80, height: doIt ? 100 : 80)
                .scaleEffect(doIt ? 4 : 1)
                .rotationEffect(.degrees(doIt ? 360 : 0))
                .shadow(
                    color: doIt ? .red.opacity(0.8) : .clear,
                    radius: doIt ? 24 : 0,
                    x: doIt ? 10 : 0,
                    y: doIt ? 10 : 0
                )
                .blur(radius: doIt ? 120 : 0)
                .offset(
                    x: doIt ? CGFloat.random(in: -100...100) : 0,
                    y: doIt ? -200 : 0
                )
                .opacity(doIt ? 0.8 : 1)
                .brightness(doIt ? 0.2 : 0)
                .animation(
                    .spring(
                        response: doIt ? 0.8 : 0.4,
                        dampingFraction: doIt ? 0.6 : 0.8,
                        blendDuration: 0.5
                    ),
                    value: doIt
                )
                .transition(
                    .asymmetric(
                        insertion: .scale(scale: doIt ? 4 : 1)
                            .combined(with: .opacity)
                            .combined(with: .slide),
                        removal: .scale(scale: doIt ? 0.1 : 1)
                            .combined(with: .opacity)
                    )
                )
            Spacer()
            Button("动一下") {
                withAnimation {
                    if doIt {
                        doIt = false
                    }else {
                        doIt = true
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AnimationTest()
}
