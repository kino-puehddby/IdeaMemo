//
//  NavigationReducer.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/30.
//
//

import ReSwift

extension NavigationState {
    public static func reducer(action: ReSwift.Action, state: NavigationState?) -> NavigationState {
        var state = state ?? NavigationState()
        guard let action = action as? NavigationState.Action else { return state }

        switch action {
        case .startTransition:
            state.isTransitioning = true
        case .push(screen: let screen):
            state.screenStack.append(screen)
        case .pop:
            if state.screenStack.count >= 2 {
                state.screenStack.removeLast()
            } else {
                state.error = AppError.system
            }
        case .pushModal(screen: let screen):
            state.newModalScreen = screen
        case .popModal:
            state.newModalScreen = nil
        case .resetPush(let screen):
            state.screenStack.removeAll()
            state.screenStack.append(screen)
        case .completeTransition:
            state.isTransitioning = false
        }

        return state
    }
}
