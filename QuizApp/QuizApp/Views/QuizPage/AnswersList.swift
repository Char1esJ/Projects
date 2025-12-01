//
//  AnswersList.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct AnswersList: View {
    @ObservedObject var viewModel: QuizViewModel
    @State var isTapEnabled = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                ForEach(viewModel.shuffledAnswers) { item in
                    HStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(changeColor(of: item))
                                .cornerRadius(10)
                                .frame(height: 67)
                            HStack {
                                Image(systemName: changeIcon(of: item))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text(item.text)
                                    .font(.headline)
                            }
                            .padding(.leading, 20)
                        }
                    }
                    .onTapGesture {
                        if isTapEnabled {
                            viewModel.selectedAnswerID = item.id
                            isTapEnabled = false
                            
                            viewModel.storeCorrectAnswers(for: item)
                            viewModel.storeWrongAnswers(for: item)
                            viewModel.storeAllAnsweredQuestions(for: item)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                viewModel.showAnswers = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                viewModel.generateNewQuestion()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                viewModel.showAnswers = true
                                isTapEnabled = true
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            .opacity(viewModel.showAnswers ? 1 : 0)
            .animation(.easeOut(duration: 0.5), value: viewModel.showAnswers)
            .padding(.top, 41)
            .padding(.bottom, 20)
        }
    }
    
    func changeColor(of item: Answers) -> Color {
        guard viewModel.selectedAnswerID != nil else {
            return .white
        }
        
        if item.id == viewModel.selectedAnswerID && !item.isCorrect {
            return .red
        }
        
        if item.isCorrect && viewModel.selectedAnswerID != nil {
            return .green
        }
        
        return .white
    }
    
    func changeIcon(of item: Answers) -> String {
        guard viewModel.selectedAnswerID != nil else {
            return "circle"
        }
        
        if item.id == viewModel.selectedAnswerID && !item.isCorrect {
            return "circle"
        }
        
        if item.isCorrect && viewModel.selectedAnswerID != nil {
            return "checkmark.circle.fill"
        }
        
        return "circle"
    }
}
