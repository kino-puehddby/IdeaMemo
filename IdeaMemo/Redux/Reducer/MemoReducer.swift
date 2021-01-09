//
//  MemoReducer.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/06.
//
//

import ReSwift

extension MemoState {
    public static func reducer(action: ReSwift.Action, state: MemoState?) -> MemoState {
        var state = state ?? MemoState()
        guard let action = action as? MemoState.Action else { return state }

        switch action {
        case .set(let memoList):
            state.error = nil
            state.memoList = memoList
        case .update(let memo):
            state.error = nil
            if let index = state.memoList.firstIndex(of: memo) {
                state.memoList[index] = memo
            } else {
                state.memoList.append(memo)
            }
        case .remove(let memo):
            if let index = state.memoList.firstIndex(of: memo) {
                state.error = nil
                state.memoList.remove(at: index)
            } else {
                state.error = AppError.system
            }
        case .error(let error):
            state.error = error
        }

        return state
    }
}
