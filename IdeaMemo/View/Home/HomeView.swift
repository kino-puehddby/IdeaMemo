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
            GeometryReader { geometry in
                Color(Asset.Colors.primaryBackgroundColor.color)
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    NavigationView {
                        List(memos, id: \.id) { memo in
                            MemoRow(memo: memo)
                        }
                        .listStyle(InsetListStyle())
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .padding(.horizontal)
                        .navigationBarTitle("ホーム", displayMode: .inline)
                        .navigationBarItems(trailing: Button(action: {
                            debugPrint("ナビゲーションボタンがタップされた")
                            viewModel.signOut()
                        }) {
                            Image(uiImage: Asset.Images.setting.image)
                                .frame(width: 30, height: 30, alignment: .center)
                        })
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }

                Button(action: {
                    
                }) {
                    Image(uiImage: Asset.Images.addMemo.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50, alignment: .center)
                }
                .frame(width: 50, height: 50, alignment: .center)
                .position(x: geometry.size.width - 55, y: geometry.size.height - 40)
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
