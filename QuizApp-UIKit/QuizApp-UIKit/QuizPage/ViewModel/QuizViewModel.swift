//
//  QuizViewModel.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/30/25.
//

import UIKit

class QuizViewModel {
    
    private(set) var quizContent: [Result] = []
    
    private let fileManager = FileManager.default
    
    func fetchData() {
        guard let bundlePath = Bundle.main.resourcePath else { return }
        
        let filePath = (bundlePath as NSString).appendingPathComponent("Questions1.json")
        
        guard fileManager.fileExists(atPath: filePath),
              let data = fileManager.contents(atPath: filePath),
              let response = try? JSONDecoder().decode(Quiz.self, from: data) else {
            print("Failed to load questions")
            return
        }
        
        quizContent = response.results
    }
}
