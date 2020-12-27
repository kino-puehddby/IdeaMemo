//
//  AuthenticationState.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/22.
//
//

import ReSwift

public struct AuthenticationState: ReSwift.StateType {
    public internal(set) var isSignIn: Bool = false
    public internal(set) var error: AppError?
}
