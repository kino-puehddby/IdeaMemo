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
    @State var pushToSettingActive: Bool = false
    @State var pushToMemoActive: Bool = false

    var body: some View {
        if viewModel.isSignIn {
            GeometryReader { geometry in
                Color(Asset.Colors.primaryBackgroundColor.color)
                    .edgesIgnoringSafeArea(.all)
                NavigationView {
                    ZStack {
                        VStack {
                            NavigationLink(destination: SettingView(), isActive: $pushToSettingActive) {
                                EmptyView()
                            }
                            .navigationBarTitle(L10n.Screen.Home.title, displayMode: .inline)
                            .navigationBarItems(trailing: Button(action: {
                                pushToSettingActive = true
                            }) {
                                Image(uiImage: Asset.Images.setting.image)
                                    .frame(width: 30, height: 30, alignment: .center)
                            })
                            .navigationBarTitleDisplayMode(.inline)
                            
                            MemoList(memoList: viewModel.memoList)
                                .frame(width: geometry.size.width, height: geometry.size.height)
//                                .onDelete(perform: self.deleteRow)
                        }

                        CreateMemoButton()
                            .position(x: geometry.size.width - 50, y: geometry.size.height - 80)
                    }
                    .onAppear {
                        viewModel.loadList()
                    }
                }
            }
        } else {
            AuthenticationView()
        }
    }
    
//    private func deleteRow(at indexSet: IndexSet) {
//        indexSet
//            .map { viewModel.memoList[$0] }
//            .forEach { memo in
//                ApplicationStore.shared.dispatch(MemoState.Action.remove(memo))
//            }
//    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}
