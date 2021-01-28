//
//  AuthenticationActions.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/22.
//
//

import ReSwift

// Actions
extension AuthenticationState {
    public enum Action: ReSwift.Action {
        case startAuthenticate
        case completeSignIn
        case completeSignOut
        case error(AppError)
    }
}
