//
//  AnswersButtonView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class AnswersButtonView: UIView {
    // MARK: - Properties
    
    private var correctAnswer: Int = 0
    private var wrongAnswer: Int = 0
    
    lazy private var loginButton = UIButton.make(title: "Correct Answer \(correctAnswer) / Incorrect \(wrongAnswer)")
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateCounts(correct: Int, wrong: Int) {
        self.correctAnswer = correct
        self.wrongAnswer = wrong
        updateButtonInfo()
    }
    
    private func updateButtonInfo() {
        loginButton.setTitle("Correct Answer \(correctAnswer) / Incorrect \(wrongAnswer)", for: .normal)
    }
}
