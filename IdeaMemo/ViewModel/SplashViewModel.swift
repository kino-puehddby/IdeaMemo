//
//  SplashViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import ReSwift

final class SplashViewModel: ObservableObject, Identifiable {
    @Published var isLogin: Bool = false

    init() {
        
    }
}
