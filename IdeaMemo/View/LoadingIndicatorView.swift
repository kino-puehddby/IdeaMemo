//
//  LoadingIndicatorView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import SwiftUI

struct LoadingIndicatorView: View {
    let isLoading: Bool
    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.black)
                    .opacity(0.15)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .disabled(self.isLoading)

                let circleGradient = AngularGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0), .accentColor]), center: .center)
                let circleStrokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round, miterLimit: 0, dashPhase: 8)
                let animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
                Circle()
                    .trim(from: 0, to: 1.0)
                    .stroke(circleGradient, style: circleStrokeStyle)
                    .frame(width: 35, height: 35)
                    .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
                    .onAppear {
                        withAnimation(animation) {
                            self.isAnimating = true
                        }
                    }
                    .onDisappear {
                        self.isAnimating = false
                    }
            }
            .hidden(!self.isLoading) // Loading中のみ表示する
        }
    }
}
