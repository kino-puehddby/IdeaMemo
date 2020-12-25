//
//  AuthenticationReducer.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/22.
//
//

import ReSwift

extension AuthenticationState {
    public static func reducer(action: ReSwift.Action, state: AuthenticationState?) -> AuthenticationState {
        var state = state ?? AuthenticationState()
        guard let action = action as? AuthenticationState.Action else { return state }

        switch action {
        case .completeSignIn:
            state.isSignIn = true
        case .completeSignOut:
            state.isSignIn = false
        }

        return state
    }
}
