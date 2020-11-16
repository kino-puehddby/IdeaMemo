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

public struct ApplicationState: ReSwift.StateType {
    public internal(set) var favoriteState = FavoriteState()
}

extension RxStore where AnyStateType == ApplicationState {
    var favoriteState: Driver<FavoriteState> {
        return stateDriver
            .map { $0.favoriteState }
            .skip(1)
    }
}
