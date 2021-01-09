//
//  MemoState.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/06.
//
//

import ReSwift

public struct MemoState: ReSwift.StateType {
    public internal(set) var memoList: [Memo] = []
    public internal(set) var error: Error?
}
