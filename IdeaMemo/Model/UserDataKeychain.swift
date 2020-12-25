//
//  UserDataKeychain.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import Foundation

struct UserDataKeychain: Keychain {
    // Make sure the account name doesn't match the bundle identifier!
    var account: String
    var service: String

    typealias DataType = User
}
