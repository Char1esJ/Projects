//
//  AnswersCell.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class AnswersCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let questionLabel = UILabel.make(text: "Answer 1", weight: .light, color: .black)
    
    private let checkMark: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "CheckMarkNil")
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

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
        contentView.addSubview(checkMark)
        backgroundColor = .white
        layer.cornerRadius = 20
    
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: checkMark.leadingAnchor, constant: 40),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkMark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 25),
            checkMark.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func configure(label: String) {
        questionLabel.text = label
    }
    
    func configureStyle(isCorrect: Bool) {
        if isCorrect {
            backgroundColor = UIColor(named: "LoginButtonColor")
            checkMark.image = UIImage(named: "CheckMarkFill")
        } else {
            backgroundColor = .white
            checkMark.image = UIImage(named: "CheckMarkWrong")
        }
    }
}
