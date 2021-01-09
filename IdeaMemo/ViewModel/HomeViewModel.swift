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

final class HomeViewModel: ObservableObject, Identifiable {
    @Published var username: String = ""
    @Published var status: StatusText = StatusText(content: "NG", color: .red)
    
    // Output
    @Published var isSignIn: Bool = true
    @Published var error: Error?
    @Published var memoList: [Memo] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    struct StatusText {
        let content: String
        let color: Color
    }

    init() {
        ApplicationStore.shared.memoState.map { $0.memoList }
            .sink { [weak self] memoList in
                guard let self = self else { return }
                self.memoList = memoList
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
                self.error = error
            }
        }
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
