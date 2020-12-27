//
//  UITraitCollection+DarkMode.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/28.
//

import UIKit

extension UITraitCollection {
    public static var isDarkMode: Bool {
        return current.userInterfaceStyle == .dark
    }
}
