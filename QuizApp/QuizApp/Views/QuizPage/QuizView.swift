//
//  QuizView.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI
import Foundation

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        ZStack {
            BackgroundColor()
                .ignoresSafeArea()
            
            if viewModel.quizCompleted {
                VStack(spacing: 30) {
                    Text("Game Over!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    Text("Reset your stats to play again")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
            } else {
                VStack {
                    HeaderSection(viewModel: viewModel)
                    ScrollView {
                        Text(viewModel.questions[viewModel.questionNumber])
                    }
                    .frame(maxHeight: 200)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(.horizontal, 20)
                    .padding(.top, 50)
                    .opacity(viewModel.showAnswers ? 1 : 0)
                    .animation(.easeOut(duration: 0.5), value: viewModel.showAnswers)
                    
                    AnswersList(viewModel: viewModel)
                }
            }
        }
    }
}
