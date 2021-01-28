//
//  MemoActions.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/06.
//
//

import Combine
import ReSwift

// Actions
extension MemoState {
    public enum Action: ReSwift.Action {
        case set(list: [Memo])
        case update(Memo)
        case remove(Memo)
        case error(Error)
    }
}
