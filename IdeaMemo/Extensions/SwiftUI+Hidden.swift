//
//  SwiftUI+Hidden.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/25.
//

import SwiftUI

struct Hidden: ViewModifier {
    let hidden: Bool

    func body(content: Content) -> some View {
        VStack {
            if !hidden {
                content
            }
        }
    }
}

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        ModifiedContent(content: self, modifier: Hidden(hidden: isHidden))
    }
}
