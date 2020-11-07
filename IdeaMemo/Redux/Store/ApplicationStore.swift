//
//  ApplicationStore.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import ReSwift
import RxSwift
import RxCocoa

final public class ApplicationStore {

    private static let instance = ApplicationStore()
    private let store: RxStore<ApplicationState>
    
    public static var shared: RxStore<ApplicationState> {
        return instance.store
    }
    
    private init() {
        store = RxStore(store: ReSwift.Store<ApplicationState>(
            reducer: appReducer,
            state: nil,
            middleware: [
                loggingMiddleware
            ]
        ))
    }
}
