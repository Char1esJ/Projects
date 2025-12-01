//
//  ad.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/30/25.
//

struct Quiz: Decodable {
 
    let code: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case code = "response_code"
        case results = "results"
    }
}
 
struct Result: Decodable {
    let questionNumber: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case questionNumber = "questionNumber"
        case difficulty = "difficulty"
        case category = "category"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
