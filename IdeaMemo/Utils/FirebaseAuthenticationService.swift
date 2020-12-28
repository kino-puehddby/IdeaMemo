//
//  FirebaseAuthenticationService.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthenticationService {
    func linkMultipleAuthProviders(user: User, credential: AuthCredential)
}

extension FirebaseAuthenticationService {
    func linkMultipleAuthProviders(user: User, credential: AuthCredential) {
        user.link(with: credential) { authResult, error in
            guard error == nil, let authResult = authResult else {
                debugPrint(error!.localizedDescription)
                return
            }

            // User is linked to multiple auth providers.
            print("link succeed")
            print("authResult: \(authResult)")
        }
    }
}
