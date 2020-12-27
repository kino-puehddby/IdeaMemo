//
//  SignInWithAppleToFirebaseButon.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import SwiftUI
import AuthenticationServices
import CryptoKit
import FirebaseAuth

final class SignInWithApple: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline )
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}

final class SignInWithAppleToFirebase: UIViewControllerRepresentable {
    private var appleSignInDelegates: SignInWithAppleDelegates!
    private var currentNonce: String?
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIHostingController(rootView: SignInWithApple().onTapGesture(perform: showAppleLogin))
        return vc as UIViewController
    }
  
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
        
    }
    
    private func showAppleLogin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        performSignIn(using: [request])
    }

    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        guard let currentNonce = self.currentNonce else {
            return
        }
        appleSignInDelegates = SignInWithAppleDelegates(window: nil, currentNonce: currentNonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = appleSignInDelegates
        authorizationController.presentationContextProvider = appleSignInDelegates
        authorizationController.performRequests()
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(L10n.Error.generateNonce(Int(errorCode)))
                }
                return random
            }

            randoms.forEach { random in
                if length == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}
