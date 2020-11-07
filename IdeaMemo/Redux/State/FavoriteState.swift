//
//  FavoriteState.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/22.
//Copyright © 2020 mycity. All rights reserved.
//

import ReSwift

public struct FavoriteState: ReSwift.StateType {
    public internal(set) var isLoading: Bool = false
    public internal(set) var error: Error?
}
