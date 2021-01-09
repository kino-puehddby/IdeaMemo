//
//  MemoRowViewModel.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/09.
//

import Foundation

final class MemoRowViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
