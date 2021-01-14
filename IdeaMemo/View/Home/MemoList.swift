//
//  MemoList.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/14.
//

import SwiftUI

struct MemoList: View {
    var memoList: [Memo]
    
    var body: some View {
        List(memoList, id: \.id) { memo in
            NavigationLink(destination: MemoView(memo: memo)) {
                MemoRow(memo: memo)
            }
        }
        .listStyle(InsetListStyle())
    }
}
