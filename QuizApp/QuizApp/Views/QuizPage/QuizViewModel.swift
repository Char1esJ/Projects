//
//  QuizViewModel.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import Foundation
import Combine

class QuizViewModel: ObservableObject {
    let quizData: QuizData = Bundle.main.decode("questions.json")
    
    @Published var questionNumber = UserDefaults.standard.integer(forKey: "questionNumber")
    @Published var selectedAnswerID: Int? = nil
    @Published var correctAnswers = UserDefaults.standard.integer(forKey: "correctAnswers")
    @Published var wrongAnswers = UserDefaults.standard.integer(forKey: "wrongAnswers")
    @Published var allAnsweredQuestions = UserDefaults.standard.integer(forKey: "allAnsweredQuestions")
    @Published var currentQuestion: Int = 0
    @Published var shuffledAnswers: [Answers] = []
    @Published var questions: [String] = []
    @Published var showAnswers: Bool = true
    @Published var quizCompleted = false
    
    init() {
        loadAnswers()
        loadQuestions()
    }
    
    func loadQuestions() {
        let questionsArray = quizData.questions.map { $0.question }
        questions = questionsArray
    }
    
    func loadAnswers(){
        let answers = quizData.questions.map { $0.answers }
        let answer = answers[questionNumber].shuffled()
        shuffledAnswers = answer
    }
    
    func generateNewQuestion() {
        selectedAnswerID = nil
        if questionNumber < 29 {
            questionNumber += 1
            UserDefaults.standard.set(questionNumber, forKey: "questionNumber")
            loadAnswers()
        } else {
            quizCompleted = true
        }
    }
    
    func storeCorrectAnswers(for item: Answers) {
        if item.isCorrect {
            correctAnswers += 1
            UserDefaults.standard.set(correctAnswers, forKey: "correctAnswers")
        }
    }
    
    func storeWrongAnswers(for item: Answers) {
        if !item.isCorrect {
            wrongAnswers += 1
            UserDefaults.standard.set(wrongAnswers, forKey: "wrongAnswers")
        }
    }
    
    func storeAllAnsweredQuestions(for item: Answers) {
        allAnsweredQuestions += 1
        UserDefaults.standard.set(allAnsweredQuestions, forKey: "allAnsweredQuestions")
    }
    
    func resetStats() {
        allAnsweredQuestions = 0
        correctAnswers = 0
        wrongAnswers = 0
        questionNumber = 0
        quizCompleted = false
        
        UserDefaults.standard.set(0, forKey: "correctAnswers")
        UserDefaults.standard.set(0, forKey: "wrongAnswers")
        UserDefaults.standard.set(0, forKey: "allAnsweredQuestions")
        
        loadAnswers()
    }
}
