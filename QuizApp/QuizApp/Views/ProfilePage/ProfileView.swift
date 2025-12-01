//
//  as.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: QuizViewModel
    var body: some View {
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image("Brain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                StatsView(viewModel: viewModel)
                
                Button {
                    viewModel.resetStats()
                } label: {
                    Text("Reset")
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(
                            Capsule()
                                .fill(.red)
                        )
                }
                .padding(.top, 100)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
