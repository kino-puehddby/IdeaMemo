//
//  HomeView.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/19.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text($viewModel.status.wrappedValue.content)
                    .foregroundColor($viewModel.status.wrappedValue.color)
                Spacer()
            }
            TextField("Placeholder", text: $viewModel.username, onEditingChanged: { changed in
                print("onEditingChanged: \(changed)")
            }, onCommit: {
                print("onCommit")
            })
        }
        .padding(.horizontal)
        .onAppear(perform: viewModel.onAppear)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
