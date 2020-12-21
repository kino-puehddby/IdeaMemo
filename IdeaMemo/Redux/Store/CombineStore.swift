//
//  CombineStore.swift
//  myplace-for-office-nampeidai-ios
//
//  Created by Hisaya Sugita on 2020/10/21.
//  Copyright © 2020 mycity. All rights reserved.
//

import Foundation
import Combine
import ReSwift

public class CombineStore<AnyStateType>: ReSwift.StoreSubscriber where AnyStateType: ReSwift.StateType {

    public lazy var statePublisher: AnyPublisher<AnyStateType, Never> = {
        stateSubject.eraseToAnyPublisher()
    }()
    
    public var state: AnyStateType { return stateSubject.value }

    private let stateSubject: CurrentValueSubject<AnyStateType, Never>
    private let store: ReSwift.Store<AnyStateType>
    
    public init(store: ReSwift.Store<AnyStateType>) {
        self.store = store
        self.stateSubject = CurrentValueSubject(store.state)
        self.store.subscribe(self)
    }
    
    deinit {
        store.unsubscribe(self)
    }
    
    public func newState(state: AnyStateType) {
        // when the state is changed
        stateSubject.value = state
    }

    public func dispatch(_ action: ReSwift.Action) {
        // make sure the action is dispatched on main thread
        if Thread.isMainThread {
            store.dispatch(action)
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.store.dispatch(action)
            }
        }
    }
}
