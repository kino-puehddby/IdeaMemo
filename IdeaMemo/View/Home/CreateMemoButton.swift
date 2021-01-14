//
//  CreateMemoButton.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2021/01/14.
//

import SwiftUI

struct CreateMemoButton: View {
    @State var pushToMemoActive: Bool = false
    
    var body: some View {
        Color(.clear)
            .edgesIgnoringSafeArea(.all)
        Button(action: {
            pushToMemoActive = true
        }) {
            Image(uiImage: Asset.Images.addMemo.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color(Asset.Colors.primaryBackgroundColor.color))
                .cornerRadius(25)
            NavigationLink(destination: MemoView(), isActive: $pushToMemoActive) {
                EmptyView()
            }
        }
    }
}
