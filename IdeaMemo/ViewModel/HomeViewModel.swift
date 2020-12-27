//
//  HomeViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/21.
//

import SwiftUI
import Combine
import FirebaseAuth

final class HomeViewModel: ObservableObject, Identifiable {
    @Published var isSignIn: Bool = true
    @Published var username: String = ""
    @Published var status: StatusText = StatusText(content: "NG", color: .red)
    
    private var cancellables: Set<AnyCancellable> = []
    
    struct StatusText {
        let content: String
        let color: Color
    }

    private var validatedUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { username -> AnyPublisher<String?, Never> in
                Future<String?, Never> { promise in
                    if 1...10 ~= username.count {
                        promise(.success(username))
                    } else {
                        promise(.success(nil))
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private(set) lazy var onAppear: () -> Void = { [weak self] in
        guard let self = self else { return }
        self.validatedUsername
            .sink { [weak self] value in
                if let value = value {
                    self?.username = value
                } else {
                    print("validatedUsername.receiveValue: Invalid username")
                }
            }
            .store(in: &self.cancellables)

        // Update StatusText
        self.validatedUsername
            .map { value -> StatusText in
                if value != nil {
                    return StatusText(content: "OK", color: .green)
                } else {
                    return StatusText(content: "NG", color: .red)
                }
            }
            .sink { [weak self] value in
                self?.status = value
            }
            .store(in: &self.cancellables)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        
        ApplicationStore.shared.dispatch(AuthenticationState.Action.completeSignOut)
        isSignIn = false
    }
}
