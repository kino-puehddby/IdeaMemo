//
//  ApplicationState.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/20.
//  Copyright © 2020 mycity. All rights reserved.
//

import ReSwift
import RxCocoa
import RxSwift

import Combine

public struct ApplicationState: ReSwift.StateType {
    public internal(set) var favoriteState = FavoriteState()
}

extension CombineStore where AnyStateType == ApplicationState {
    var favoriteState: AnyPublisher<FavoriteState, Never> {
        return statePublisher
            .map { $0.favoriteState }
            .dropFirst()
            .eraseToAnyPublisher()
    }
}
