//
//  SettingView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/01.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel = SettingViewModel()

    var body: some View {
        Text("設定画面")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
