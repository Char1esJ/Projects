//
//  ContentView.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QuizViewModel()
    var body: some View {
        TabView {
            QuizView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "square.stack.3d.up.fill")
                    Text("Quiz")
                }
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "doc.text.image.fill")
                    Text("Profile")
                }
        }
    }
}
