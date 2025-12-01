//
//  TopView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class TopView: UIView {
    // MARK: - Properties
    
    private let titleLabel = UILabel.make(text: "Quiz", fontSize: 0.05, weight: .bold)
    private let resetButton = UIButton.make(title: "Reset", radius: 0.027, borderWidth: 1)
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupView()
        buttonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            resetButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            resetButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 180),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func buttonAction() {
        resetButton.addAction(UIAction { _ in
            let defaults = UserDefaults.standard
            
            if Bundle.main.bundleIdentifier != nil {
                defaults.removeObject(forKey: "correct")
                defaults.removeObject(forKey: "wrong")
            }
        }, for: .touchUpInside)
    }
}
