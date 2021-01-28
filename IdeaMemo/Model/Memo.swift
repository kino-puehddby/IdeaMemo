//
//  Memo.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Foundation

public struct Memo: Equatable {
    let id: String
    let title: String
    let content: String

    public static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}
