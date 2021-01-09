//
//  ApplicationState.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/20.
//  Copyright © 2020 mycity. All rights reserved.
//

import Combine
import ReSwift

public struct ApplicationState: ReSwift.StateType {
    public internal(set) var authenticationState = AuthenticationState()
    public internal(set) var memoState = MemoState()
}

extension CombineStore where AnyStateType == ApplicationState {
    var authenticationState: AnyPublisher<AuthenticationState, Never> {
        return statePublisher
            .map { $0.authenticationState }
            .dropFirst()
            .eraseToAnyPublisher()
    }
    
    var memoState: AnyPublisher<MemoState, Never> {
        return statePublisher
            .map { $0.memoState }
            .dropFirst()
            .eraseToAnyPublisher()
    }
}
