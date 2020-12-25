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
        case completeSignIn
        case completeSignOut
    }
}

// Action Dispatcher
public struct AuthenticationActionDispatcher {
    public static func xxxRequest() {
//        ApplicationStore.shared.dispatch(AuthenticationState.Action.requestStart)
//        API.get()
//            .subscribe(
//                onSuccess: { xxx in
//                    ApplicationStore.shared.dispatch(AuthenticationState.Action.get(parameter: xxx))
//                },
//                onError: { error in
//                    ApplicationStore.shared.dispatch(AuthenticationState.Action.requestError(error))
//                }
//            )
    }
}
