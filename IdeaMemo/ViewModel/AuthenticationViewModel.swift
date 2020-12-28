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
    @Published var isSignInCompleted = false
    @Published var isLoading = false
    @Published var error: AppError?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        ApplicationStore.shared.authenticationState.map { $0.isSignIn }
            .removeDuplicates()
            .sink { [weak self] isSignIn in
                guard let self = self else { return }
                self.isSignInCompleted = isSignIn
            }
            .store(in: &self.cancellables)
        
        ApplicationStore.shared.authenticationState.map { $0.error }
            .filterNil()
            .removeDuplicates()
            .sink { [weak self] error in
                guard let self = self else { return }
                self.error = error
            }
            .store(in: &self.cancellables)
        
        ApplicationStore.shared.authenticationState.map { $0.isLoading }
            .removeDuplicates()
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                self.isLoading = isLoading
            }
            .store(in: &self.cancellables)
    }
}
