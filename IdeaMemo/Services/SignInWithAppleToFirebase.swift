//
//  SignInWithAppleToFirebase.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import Foundation
import UIKit
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

enum AppError: LocalizedError {
    case authorization
    case network
    case server(Int)
    case system
    case business
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .authorization: return L10n.AppError.authorization
        case .network: return L10n.AppError.network
        case .server(let statusCode): return L10n.AppError.server(statusCode)
        case .system: return L10n.AppError.system
        case .business: return L10n.AppError.business
        case .unknown: return L10n.AppError.unknown
        }
    }
}

final class SignInWithAppleToFirebase: UIViewControllerRepresentable {
    private var appleSignInDelegates: SignInWithAppleDelegates!
    private let onLoginEvent: ((Result<AuthDataResult, AppError>) -> Void)?
    private var currentNonce: String?
    
    init(_ onLoginEvent: ((Result<AuthDataResult, AppError>) -> Void)? = nil) {
        self.onLoginEvent = onLoginEvent
    }
    
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
        appleSignInDelegates = SignInWithAppleDelegates(window: nil, currentNonce: currentNonce, onLoginEvent: self.onLoginEvent)

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
                    fatalError(L10n.FatalError.generateNonce(Int(errorCode)))
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

class SignInWithAppleDelegates: NSObject {
    private let onLoginEvent: ((Result<AuthDataResult, AppError>) -> Void)?
    private weak var window: UIWindow!
    private var currentNonce: String? // Unhashed nonce.

    init(window: UIWindow?, currentNonce: String, onLoginEvent: ((Result<AuthDataResult, AppError>) -> Void)? = nil) {
        self.window = window
        self.currentNonce = currentNonce
        self.onLoginEvent = onLoginEvent
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if appleIdCredential.email != nil, appleIdCredential.fullName != nil {
                saveToKeychain(credential: appleIdCredential)
            }
            firebaseLogin(credential: appleIdCredential)
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.onLoginEvent?(.failure(.authorization))
    }
    
    private func saveToKeychain(credential: ASAuthorizationAppleIDCredential) {
        guard let email = credential.email, let name = credential.fullName else { return }
        let userModel = User(
            email: email,
            name: name,
            id: credential.user
        )

        let keychain = UserDataKeychain(account: credential.user, service: "apple")
        do {
            try keychain.store(userModel)
        } catch {
            debugPrint(AppError.system.localizedDescription)
        }
    }
    
    func firebaseLogin(credential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError(L10n.FatalError.noLoginRequest)
        }
        guard let appleIDToken = credential.identityToken else {
            debugPrint(L10n.FatalError.identityToken)
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            debugPrint(L10n.FatalError.encoding(appleIDToken.debugDescription))
            return
        }

        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idTokenString,
            rawNonce: nonce
        )

        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { authResult, error in
            guard error == nil, let authResult = authResult else {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                debugPrint(error!.localizedDescription)
                self.onLoginEvent?(.failure(.authorization))
                return
            }
            // User is signed in to Firebase with Apple.
            self.onLoginEvent?(.success(authResult))
        }
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
