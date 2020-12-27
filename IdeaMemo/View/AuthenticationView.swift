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
                Color(Asset.Colors.primaryBackgroundColor.color)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center) {
                    VStack {
                        VStack {
                            Image(uiImage: Asset.Images.icon.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 230, height: 230)
                            Text("アイデアメモ")
                                .padding(.top, -15)
                                .font(.headline)
                        }
                        .padding(.vertical, 82)

                        VStack(spacing: 20) {
                            let buttonWidth: CGFloat = geometry.size.width - 60
                            let buttonHeight: CGFloat = 45
                            let buttonCornerRadius: CGFloat = 6.5
                            
                            Text("ログイン / 新規登録")
                                .font(.headline)
                                .fontWeight(.regular)

                            SignInWithAppleToFirebase()
                                .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                                .cornerRadius(buttonCornerRadius)

                            Button(action: {
                                GIDSignIn.sharedInstance().signIn()
                            }) {
                                Image(uiImage: Asset.Images.googleLogo.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 15, height: 15, alignment: .center)
                                Text("Googleでサインイン")
                                    .foregroundColor(Color(Asset.Colors.primaryBackgroundColor.color))
                                    .fontWeight(.medium)
                            }
                            .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                            .background(Color(Asset.Colors.primaryContentColor.color))
                            .cornerRadius(buttonCornerRadius)
                            .overlay(
                                RoundedRectangle(cornerRadius: buttonCornerRadius)
                                    .stroke(Color(Asset.Colors.primaryBackgroundColor.color), lineWidth: 0.8)
                            )
                        }
                        .frame(width: geometry.size.width)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        LoadingIndicatorView(isLoading: viewModel.isLoading)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthenticationView()
                .previewDevice("iPhone 12")
                .environment(\.colorScheme, .dark)
            AuthenticationView()
                .previewDevice("iPhone 12")
                .environment(\.colorScheme, .dark)
        }
    }
}
