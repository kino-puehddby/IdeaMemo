//
//  AuthenticationView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn

struct AuthenticationView: View {
    @ObservedObject var viewModel = AuthenticationViewModel()
    @EnvironmentObject var signInWithGoogleDelegate: SignInWithGoogleDelegate

    var body: some View {
        if viewModel.isSignInCompleted {
            HomeView()
        } else {
            GeometryReader { geometry in
                VStack {
                    VStack(alignment: .center, spacing: 30) {
                        Image(uiImage: Asset.Assets.icon.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                        Text("アイデアメモ")
                    }
                    .padding(.vertical, 82)

                    VStack(alignment: .center, spacing: 20) {
                        SignInWithAppleToFirebase()
                            .signInWithAppleButtonStyle(.black)
                            .frame(width: .none, height: 45, alignment: .center)
                            .cornerRadius(6.5)
                            .padding(.horizontal, 30)

                        Button(action: {
                            GIDSignIn.sharedInstance().signIn()
                        }) {
                            Image(uiImage: Asset.Assets.googleLogo.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15, alignment: .center)
                            Text("Googleでサインイン")
                                .foregroundColor(Color(Asset.Colors.primaryBackgroundColor.color))
                        }
                        .frame(width: geometry.size.width - 60, height: 45, alignment: .center)
                        .background(Color(Asset.Colors.primaryContentColor.color))
                        .cornerRadius(6.5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.5)
                                .stroke(Color(Asset.Colors.primaryBackgroundColor.color), lineWidth: 0.8)
                        )
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
        LoadingIndicatorView(isLoading: viewModel.isLoading)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .previewDevice("iPhone 12")
            .environment(\.colorScheme, .dark)
    }
}
