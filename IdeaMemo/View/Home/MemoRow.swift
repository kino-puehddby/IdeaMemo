//
//  MemoRow.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import SwiftUI

struct MemoRow: View {
    @ObservedObject var viewModel: MemoRowViewModel
    
    init(memo: Memo) {
        viewModel = MemoRowViewModel(memo: memo)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewModel.memo.title)
                .font(.headline)
                .foregroundColor(Color(Asset.Colors.primaryContentColor.color))
            Text(viewModel.memo.content)
                .font(.subheadline)
                .foregroundColor(Color(Asset.Colors.secondaryContentColor.color))
        }
        .background(Color(.clear))
        .frame(width: .none, height: 50, alignment: .leading)
    }
}
