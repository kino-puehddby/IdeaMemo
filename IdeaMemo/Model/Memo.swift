//
//  Memo.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Foundation

struct Memo: Codable, Equatable {
    let id: Int
    let title: String
    let content: String

    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}
