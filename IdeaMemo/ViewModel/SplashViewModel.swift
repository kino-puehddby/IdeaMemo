//
//  SplashViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import ReSwift

final class SplashViewModel: ViewModelProtocol {
    var isLogin: Bool = ApplicationStore.shared.state.authenticationState.isSignIn
}
