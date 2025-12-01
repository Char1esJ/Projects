//
//  GenresV.swift
//  Assignment-N19
//
//  Created by Charles Janjgava on 10/21/25.
//

import UIKit

class GenresV: UIView {
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
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
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func createGenreBtn(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text.uppercased(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.53, green: 0.64, blue: 0.91, alpha: 1.00), for: .normal)
        button.backgroundColor = UIColor(red: 0.86, green: 0.89, blue: 1.00, alpha: 1.00)
        button.layer.cornerRadius = 13
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }
    
    func configure(genres: [String]) {
        genres.forEach {
            stackView.addArrangedSubview(createGenreBtn(text: $0))
        }
    }
}
