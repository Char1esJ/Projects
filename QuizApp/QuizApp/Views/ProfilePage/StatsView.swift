//
//  StatsView.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var viewModel: QuizViewModel

    @State private var sliderValue: Double = 0
    private let maxValue: Double = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(spacing: 15) {
                Text("Username")
                Text("Charles")
                    .bold()
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Questions answered")
                Text("\(viewModel.allAnsweredQuestions)")
                    .bold()
                    .padding(.leading, 8)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Correct answers")
                Text("\(viewModel.correctAnswers)")
                    .bold()
                    .padding(.leading, 8)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Stats:")
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.gray.opacity(0.3))
                        
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(.green)
                                .frame(width: viewModel.allAnsweredQuestions == 0 ? 0 : geo.size.width * CGFloat(viewModel.correctAnswers) / CGFloat(viewModel.allAnsweredQuestions))
                            
                            Rectangle()
                                .fill(.red)
                                .frame(width: viewModel.allAnsweredQuestions == 0 ? 0 : geo.size.width * CGFloat(viewModel.wrongAnswers) / CGFloat(viewModel.allAnsweredQuestions))
                        }
                        .opacity(viewModel.allAnsweredQuestions == 0 ? 0 : 1)
                        .animation(.easeInOut(duration: 0.8), value: viewModel.allAnsweredQuestions)
                    }
                }
                .frame(height: 35)
                .cornerRadius(15)
            }
        }
        .foregroundStyle(.white)
        .font(.title2)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}
