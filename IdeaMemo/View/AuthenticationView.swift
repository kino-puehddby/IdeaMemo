//
//  AuthenticationView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @ObservedObject var viewModel = AuthenticationViewModel()
    @State private var isLoading = false

    var body: some View {
        if viewModel.isLoginCompleted {
            HomeView()
        } else {
            GeometryReader { geometry in
                VStack {
                    VStack(alignment: .center, spacing: 30) {
                        Image(uiImage: Asset.Assets.icon.image)
                            .frame(width: 180, height: 180)
                        Text("アイデアメモ")
                    }
                    .padding(.vertical, 82)

                    VStack(alignment: .center, spacing: 100) {
                        SignInWithAppleToFirebase { result in
                            isLoading = false
                            viewModel.firebaseAuthResult = result
                        }
                        .signInWithAppleButtonStyle(.black)
                        .frame(width: .none, height: 45, alignment: .center)
                        .onTapGesture {
                            isLoading = true
                        }
                        .padding(.horizontal, 30)
                    }
                    .frame(width: geometry.size.width)
                }
                
                LoadingIndicatorView(isLoading: self.isLoading)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environment(\.colorScheme, .dark)
    }
}
