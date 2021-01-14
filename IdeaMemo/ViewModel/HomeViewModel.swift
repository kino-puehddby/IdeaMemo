//
//  HomeViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/21.
//

import SwiftUI
import Combine
import FirebaseAuth
import CloudKit

final class HomeViewModel: ObservableObject {
    // Output
    @Published var isSignIn: Bool = true
    @Published var error: Error?
    @Published var memoList: [Memo] = []
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        ApplicationStore.shared.memoState.map { $0.memoList }
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] memoList in
                guard let self = self else { return }
                self.memoList = memoList
            }
            .store(in: &self.cancellables)
        
        ApplicationStore.shared.memoState.map { $0.error }
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.error = nil
                    return
                }
                self.error = error
            }
            .store(in: &self.cancellables)
    }

    func loadList() {
        CloudMemoRecord.get { result in
            switch result {
            case .success(let memoList):
                DispatchQueue.main.async {
                    self.memoList = memoList
                }
                ApplicationStore.shared.dispatch(MemoState.Action.set(list: memoList))
            case .failure(let error):
                ApplicationStore.shared.dispatch(MemoState.Action.error(error))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            ApplicationStore.shared.dispatch(AuthenticationState.Action.error(.authorization))
        }
        
        ApplicationStore.shared.dispatch(AuthenticationState.Action.completeSignOut)
        isSignIn = false
    }
}
