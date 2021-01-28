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
            VStack(alignment: .leading, spacing: 20) {
                TextField("タイトル", text: $viewModel.title, onCommit: {
                    viewModel.commitEvent.send(())
                })
                .frame(height: 50)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(Asset.Colors.primaryContentColor.color))
                
                MemoTextView(text: $viewModel.content)
                    .frame(height: geometry.size.height)
                    .foregroundColor(Color(Asset.Colors.primaryContentColor.color))
            }
        }
        .padding(.vertical, 20)
        .background(Color(Asset.Colors.primaryBackgroundColor.color).edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.createMemoIfNeeded()
        }
        .onWillDisappear {
            viewModel.deleteUnnecessaryMemo()
        }
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
            .previewDevice("iPhone 12")
            .environment(\.colorScheme, .dark)
    }
}
