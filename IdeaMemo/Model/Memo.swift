//
//  Memo.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Foundation

struct Memo: Codable, Equatable {
    let id: String
    let title: String
    let sentence: String

    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}
