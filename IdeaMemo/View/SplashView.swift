//
//  SplashView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/10/05.
//  Copyright © 2020 Hisaya Sugita. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    @State private var isLogin = true
    
    var body: some View {
        if isLogin {
            HomeView()
        } else {
            AuthenticationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
