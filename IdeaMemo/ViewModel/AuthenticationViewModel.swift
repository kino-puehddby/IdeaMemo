//
//  AuthenticationViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import Combine
import AuthenticationServices
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject, Identifiable {
    @Published var firebaseAuthResult: Result<AuthDataResult, AppError>?
    @Published var isLoginCompleted = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $firebaseAuthResult
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let authResult):
                    debugPrint("userIdentifier: \(authResult.user)")
                    ApplicationStore.shared.dispatch(AuthenticationState.Action.completeSignIn)
                    self.isLoginCompleted = true
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .none:
                    break
                }
            }
            .store(in: &self.cancellables)
    }
}
