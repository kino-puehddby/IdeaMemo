//
//  ContentView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/10/05.
//  Copyright © 2020 Hisaya Sugita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
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
        ContentView()
            .previewDevice("iPhone 12")
            .environment(\.colorScheme, .dark)
    }
}
