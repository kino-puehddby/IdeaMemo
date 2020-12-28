//
//  LoadingIndicatorView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimating = false
    
    let isLoading: Bool
    let opacity: Double
    let duration: Double
    
    init(isLoading: Bool, opacity: Double = 0.01, duration: Double = 0.2) {
        self.isLoading = isLoading
        self.opacity = opacity
        self.duration = duration
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let backgroundAnimation = Animation.linear(duration: duration)
                Color(.black)
                    .opacity(isLoading ? opacity : 0.01)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .disabled(isLoading)
                    .animation(backgroundAnimation)

                let circleGradient = AngularGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0), .accentColor]), center: .center)
                let circleStrokeStyle = StrokeStyle(lineWidth: 4, lineCap: .round, miterLimit: 0, dashPhase: 8)
                let circleAnimation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
                Circle()
                    .trim(from: 0, to: 1.0)
                    .stroke(circleGradient, style: circleStrokeStyle)
                    .frame(width: 35, height: 35)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .onAppear {
                        withAnimation(circleAnimation) {
                            self.isAnimating = true
                        }
                    }
                    .onDisappear {
                        self.isAnimating = false
                    }
            }
            .hidden(!isLoading) // Loading中のみ表示する
        }
    }
}
