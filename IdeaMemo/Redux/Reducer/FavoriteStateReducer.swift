//
//  FavoriteStateReducer.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/22.
//Copyright © 2020 mycity. All rights reserved.
//

import ReSwift

extension FavoriteState {
    public static func reducer(action: ReSwift.Action, state: FavoriteState?) -> FavoriteState {
        var state = state ?? FavoriteState()
        guard let action = action as? FavoriteState.Action else { return state }

        switch action {
        case .requestStart:
            state.isLoading = true
            state.error = nil
        case .requestError(let error):
            state.isLoading = false
            state.error = error
        case .systemError(let error):
            state.error = error
        }

        return state
    }
}
