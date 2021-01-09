//
//  AppUser.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import Foundation

struct AppUser: Codable, Equatable {
    let email: String
    let name: PersonNameComponents
    let id: String
    
    static func == (lhs: AppUser, rhs: AppUser) -> Bool {
        return lhs.id == rhs.id
    }
}
