//
//  Question.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import Foundation

struct QuizData: Decodable {
    let questions: [Question]
}

struct Question: Decodable, Identifiable {
    let id: Int
    let question: String
    let answers: [Answers]
}

struct Answers: Decodable, Identifiable {
    let id: Int
    let text: String
    let isCorrect: Bool
}
