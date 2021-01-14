//
//  MemoView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/29.
//

import SwiftUI
import CloudKit

struct MemoView: View {
    @ObservedObject var viewModel: MemoViewModel
    
    init(memo: Memo? = nil) {
        self.viewModel = MemoViewModel(memo: memo)
    }

    var body: some View {
        GeometryReader { geometry in
            TextField("タイトル", text: $viewModel.title, onCommit: {
                viewModel.commitEvent.send(())
            })
            .frame(width: geometry.size.width, height: 50, alignment: .center)
            .padding(.vertical, 30)

            TextField("説明", text: $viewModel.content, onCommit: {
                viewModel.commitEvent.send(())
            })
            .frame(width: geometry.size.width - 40, height: geometry.size.height - 50, alignment: .leading)
            .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.createMemoIfNeeded()
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
