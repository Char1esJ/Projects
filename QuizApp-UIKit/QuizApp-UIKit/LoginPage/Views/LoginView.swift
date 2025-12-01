//
//  LoginView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class LoginView: UIView {
    // MARK: - Properties
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let userNameLabel = UILabel.make(text: "Username")
    
    private let passwordLabel = UILabel.make(text: "Password")
    
    private let confirmPasswordLabel = UILabel.make(text: "Confirm password")
    
    var  userNameField = UITextField.make(placeholder: "Enter username")
    
    var passwordField = UITextField.make(placeholder: "Enter password")
    
    var confirmPasswordField = UITextField.make(placeholder: "Enter password")
    
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
        addSubview(contentStack)
        
        [userNameLabel, userNameField, passwordLabel, passwordField, confirmPasswordLabel, confirmPasswordField].forEach {
            contentStack.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27),
            contentStack.widthAnchor.constraint(equalToConstant: 400),
            contentStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -27),
            
            userNameField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
}
