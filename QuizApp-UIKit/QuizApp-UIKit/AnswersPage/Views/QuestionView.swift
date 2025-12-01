//
//  QuestionView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class QuestionView: UIView {
    // MARK: - Properties
    
    private let questionButton = UIButton.make(title: "Question 1", radius: 0.027, borderWidth: 1)
    
    private let titleLabel = UILabel.make(
        text: "How would you describe your level of satisfaction with the healthcare system?",
        fontSize: 0.03,
        weight: .bold,
        numberOfLines: 10
    )
    
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
        addSubview(questionButton)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            questionButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            questionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            questionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 250),
            questionButton.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: questionButton.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    func configure(number: String, question: String) {
        questionButton.setTitle("Question \(number)", for: .normal)
        titleLabel.text = question
    }
}
