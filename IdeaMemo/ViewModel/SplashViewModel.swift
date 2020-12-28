//
//  SplashViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import Combine
import FirebaseAuth

final class SplashViewModel: ObservableObject, Identifiable {
    @Published var isSignIn: Bool = Auth.auth().currentUser != nil
}
