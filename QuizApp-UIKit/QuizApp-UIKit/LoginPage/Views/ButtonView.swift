//
//  ButtonView.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class ButtonView: UIView {
    // MARK: - Properties
    
    private let loginButton = UIButton.make(title: "Login")
    var onLoginTapped: (()->())?

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
        addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func buttonAction() {
        loginButton.addAction(UIAction { [weak self] _ in
            self?.onLoginTapped?()
        }, for: .touchUpInside)
    }
}
