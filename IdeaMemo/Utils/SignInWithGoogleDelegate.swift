//
//  SignInWithGoogleDelegate.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import FirebaseAuth
import GoogleSignIn

class SignInWithGoogleDelegate: NSObject, ObservableObject {
    @Published var isSignIn: Bool = false
}

extension SignInWithGoogleDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))

            switch (error as NSError).code {
            case GIDSignInErrorCode.hasNoAuthInKeychain.rawValue:
                print(L10n.Error.GoogleSignIn.hasNoAuthInKeychain)
            case GIDSignInErrorCode.canceled.rawValue:
                print(L10n.Error.GoogleSignIn.canceled)
            default:
                print("\(error.localizedDescription)")
            }
            return
        }
        
        guard let authentication = user.authentication else {
            ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
            return
        }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        firebaseSigiIn(credential: credential)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
    }
    
    private func firebaseSigiIn(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { _, error in
            guard error == nil else {
                ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
                return
            }

            // User is signed in to Firebase with Google.
            ApplicationStore.shared.dispatch(AuthenticationState.Action.completeSignIn)
        }
    }
}
