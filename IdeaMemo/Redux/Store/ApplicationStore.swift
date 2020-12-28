//
//  ApplicationStore.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import ReSwift

final public class ApplicationStore {

    private static let instance = ApplicationStore()
    private let store: CombineStore<ApplicationState>
    
    public static var shared: CombineStore<ApplicationState> {
        return instance.store
    }
    
    private init() {
        store = CombineStore(store: ReSwift.Store<ApplicationState>(
            reducer: appReducer,
            state: nil,
            middleware: [
                loggingMiddleware
            ]
        ))
    }
}
