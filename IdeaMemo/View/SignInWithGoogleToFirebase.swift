//
//  SignInWithGoogleToFirebase.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth

final class SignInWithGoogleToFirebase: UIViewRepresentable {
    private var googleSignInDelegates: SignInWithGoogleDelegate!

    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.style = .wide
        button.colorScheme = .light
        return button
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    init() {
        self.googleSignInDelegates = SignInWithGoogleDelegate()
    }
}
