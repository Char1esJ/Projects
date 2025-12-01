//
//  AnswersViewModel.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/30/25.
//

import Foundation

class AnswersViewModel {
    private var result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    var correctAnswersCount: Int = 0
    var wrongAnswersCount: Int = 0
    
    var name: String {
        result.correctAnswer
    }
    
    var number: String {
        result.questionNumber
    }
    
    var question: String {
        result.question
    }
    
    lazy var answers: [String] = {
        var allAnswers = result.incorrectAnswers
        allAnswers.append(result.correctAnswer)
        
        return allAnswers.shuffled()
        
    }()
    
    var correctAnswer: String {
        result.correctAnswer
    }
}
