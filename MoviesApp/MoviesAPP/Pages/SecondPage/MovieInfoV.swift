//
//  MovieInfoV.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class MovieInfoV: UIView {
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createInfoItem(title: String, value: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 4
        
        let titleLabel = UILabel.make(text: title, fontSize: 14, weight: .regular, color: .systemGray)
        let valueLabel = UILabel.make(fontSize: 16, weight: .medium, color: .black)
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(valueLabel)
        
        return container
    }
    
    func configure(duration: String, language: String, rating: String) {
        stackView.addArrangedSubview(createInfoItem(title: "Length", value: duration))
        stackView.addArrangedSubview(createInfoItem(title: "Language", value: language))
        stackView.addArrangedSubview(createInfoItem(title: "Rating", value: rating))
    }
}
