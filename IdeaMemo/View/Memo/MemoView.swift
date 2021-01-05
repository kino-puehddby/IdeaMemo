//
//  MemoView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/29.
//

import SwiftUI

struct MemoView: View {
    @ObservedObject var viewModel = SettingViewModel()
    let memo: Memo

    var body: some View {
        Text("メモ画面")
        Text(memo.title)
        Text(memo.content)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(memo: memos[0])
    }
}
