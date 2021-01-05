//
//  NavigationState.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/29.
//
//

import ReSwift
import SwiftUI

public struct NavigationState: ReSwift.StateType {
    public internal(set) var isTransitioning: Bool = false
    public internal(set) var newModalScreen: Screen?
    public internal(set) var screenStack: [Screen] = []

    public internal(set) var error: AppError?
}

public enum Screen {
    case splash
    case authentication
    case home
    case memo
    case setting
    
    var screenView: Any {
        switch self {
        case .splash: return ContentView()
        case .authentication: return AuthenticationView()
        case .home: return HomeView()
        case .memo: return HomeView()
        case .setting: return SettingView()
        }
    }
}
