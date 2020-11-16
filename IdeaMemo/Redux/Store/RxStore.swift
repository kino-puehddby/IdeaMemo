//
//  RxStore.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import RxCocoa

public class RxStore<AnyStateType>: ReSwift.StoreSubscriber where AnyStateType: ReSwift.StateType {

    public lazy var stateDriver: Driver<AnyStateType> = {
        stateRelay.asDriver()
    }()
    public var state: AnyStateType { return stateRelay.value }

    private let stateRelay: BehaviorRelay<AnyStateType>
    private let store: ReSwift.Store<AnyStateType>
    
    public init(store: ReSwift.Store<AnyStateType>) {
        self.store = store
        self.stateRelay = BehaviorRelay(value: store.state)
        self.store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    public func newState(state: AnyStateType) {
        // when the state is changed
        stateRelay.accept(state)
    }

    public func dispatch(_ action: ReSwift.Action) {
        // make sure the action is dispatched on main thread
        if Thread.isMainThread {
            store.dispatch(action)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.store.dispatch(action)
            }
        }
    }
}
