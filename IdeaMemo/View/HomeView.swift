//
//  HomeView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        if viewModel.isSignIn {
            NavigationView {
                VStack {
                    List {
                    }
    //                HStack {
    //                    Text($viewModel.status.wrappedValue.content)
    //                        .foregroundColor($viewModel.status.wrappedValue.color)
    //                    Spacer()
    //                }
    //                TextField("Placeholder", text: $viewModel.username, onEditingChanged: { changed in
    //                    print("onEditingChanged: \(changed)")
    //                }, onCommit: {
    //                    print("onCommit")
    //                })
                }
                .padding(.horizontal)
                .onAppear(perform: viewModel.onAppear)
                .navigationBarTitle("ホーム", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    debugPrint("ナビゲーションボタンがタップされた")
                    viewModel.signOut()
                }) {
                    Image(uiImage: Asset.Images.setting.image)
                        .frame(width: 30, height: 30, alignment: .center)
                })
                .navigationBarTitleDisplayMode(.automatic)
            }
        } else {
            AuthenticationView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}
