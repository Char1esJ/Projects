//
//  QuestionsCell.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class QuestionsCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let questionLabel = UILabel.make(text: "Question 1", weight: .light, color: .black)

    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        contentView.addSubview(questionLabel)
        backgroundColor = .white
        
        layer.cornerRadius = 20
    
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(label: String) {
        questionLabel.text = "Question \(label)"
    }
}
