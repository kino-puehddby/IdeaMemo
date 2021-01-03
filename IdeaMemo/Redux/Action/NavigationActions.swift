//
//  NavigationActions.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/30.
//
//

import Combine
import ReSwift

// Actions
extension NavigationState {
    public enum Action: ReSwift.Action {
        case startTransition
        
        case push(screen: Screen)
        case pop
        case pushModal(screen: Screen)
        case popModal
        case resetPush(screen: Screen)
        
        case completeTransition
    }
}
