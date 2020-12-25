//
//  SplashView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/10/05.
//  Copyright © 2020 Hisaya Sugita. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel = SplashViewModel()
    
    var body: some View {
        if viewModel.isSignIn {
            HomeView()
        } else {
            AuthenticationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environment(\.colorScheme, .dark)
    }
}
