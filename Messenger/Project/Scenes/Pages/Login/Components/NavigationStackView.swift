//
//  navigationStackView.swift
//  Project
//
//  Created by Kristine on 16.11.25.
//

import UIKit

class NavigationStackView: UIStackView {
    
    var onSignUpTapped: (() -> Void)?
    
    private let promptNewUserLabel: UILabel = {
        let label = UILabel()
        label.text = "auth.new.user".localized
        label.font = UIFont(name: "Inter", size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let navigateToSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("auth.signup.button".localized, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Anek Devanagari", size: 14)
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        spacing = 4
        alignment = .center
        
        setupNavigationPrompt()
        setupActions()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationPrompt() {
        addArrangedSubview(promptNewUserLabel)
        addArrangedSubview(UIView())
        addArrangedSubview(navigateToSignUpButton)
    }
    
    private func setupActions() {
        navigateToSignUpButton.addAction(
            UIAction { [weak self] _ in
                self?.onSignUpTapped?()
            },
            for: .touchUpInside
        )
    }
    
    func updateLanguage(question: String, signUp: String) {
        promptNewUserLabel.text = question
        navigateToSignUpButton.setTitle(signUp, for: .normal)
    }
}
