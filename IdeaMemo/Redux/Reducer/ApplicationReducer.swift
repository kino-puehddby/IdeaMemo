//
//  ApplicationReducer.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import ReSwift

// top level Reducer
public func appReducer(action: ReSwift.Action, state: ApplicationState?) -> ApplicationState {
    var state = state ?? ApplicationState()
    
    state.favoriteState = FavoriteState.reducer(action: action, state: state.favoriteState)
    
    return state
}
