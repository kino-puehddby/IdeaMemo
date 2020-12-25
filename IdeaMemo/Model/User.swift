//
//  User.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import Foundation

struct User: Codable, Equatable {
    let email: String
    let name: PersonNameComponents
    let id: String
    let memoList: [Memo]?
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
