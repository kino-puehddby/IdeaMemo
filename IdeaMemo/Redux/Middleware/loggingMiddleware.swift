//
//  loggingMiddleware.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import ReSwift

public let loggingMiddleware: ReSwift.Middleware<ApplicationState> = { dispatch, getState in
    return { next in
        return { action in
            debugPrint("before state: \(String(describing: getState()))")
            next(action)
            debugPrint("after state: \(String(describing: getState()))")
        }
    }
}
