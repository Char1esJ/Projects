//
//  ContentView.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/23/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.HF.opacity(0.9)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    HeaderSection()
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.timers) { timer in
                                NavigationLink {
                                    DetailsView(viewModel: timer)
                                } label: {
                                    TimerItem(viewModel: timer, contentViewModel: viewModel)
                                }
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    }
                    
                    FooterSection(viewModel: viewModel)
                }
            }
        }
    }
}
