//
//  SignInWithAppleDelegates.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import FirebaseAuth
import AuthenticationServices

class SignInWithAppleDelegates: NSObject {
    private weak var window: UIWindow!
    private var currentNonce: String? // Unhashed nonce.

    init(window: UIWindow?, currentNonce: String) {
        self.window = window
        self.currentNonce = currentNonce
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if appleIdCredential.email != nil, appleIdCredential.fullName != nil {
                saveToKeychain(credential: appleIdCredential)
            }
            firebaseSignIn(appleIDCredential: appleIdCredential)
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
    }
    
    private func saveToKeychain(credential: ASAuthorizationAppleIDCredential) {
        guard let email = credential.email, let name = credential.fullName else { return }
        let userModel = AppUser(
            email: email,
            name: name,
            id: credential.user,
            memoList: []
        )

        let keychain = UserDataKeychain(account: credential.user, service: "apple")
        do {
            try keychain.store(userModel)
        } catch {
            debugPrint(AppError.system.localizedDescription)
        }
    }
    
    private func firebaseSignIn(appleIDCredential: ASAuthorizationAppleIDCredential) {
        guard let nonce = currentNonce else {
            fatalError(L10n.Error.noLoginRequest)
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            debugPrint(L10n.Error.identityToken)
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            debugPrint(L10n.Error.encoding(appleIDToken.debugDescription))
            return
        }

        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idTokenString,
            rawNonce: nonce
        )

        Auth.auth().signIn(with: credential) { _, error in
            guard error == nil else {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                debugPrint(error!.localizedDescription)
                ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
                return
            }

            // User is signed in to Firebase with Apple.
            ApplicationStore.shared.dispatch(AuthenticationState.Action.completeSignIn)
        }
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
