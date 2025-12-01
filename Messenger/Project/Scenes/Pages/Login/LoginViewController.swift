//
//  LoginViewController.swift
//  Authentication
//
//  Created by Kristine on 15.11.25.
//

import UIKit
import Core
import UIComponents

class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    
    private let applicationLogo: UILabel = {
        let label = UILabel()
        label.text = "Wazaaaaap"
        label.font = UIFont(name: "Pacifico-Regular", size: 48) 
        label.textColor = UIColor(red: 0.318, green: 0.349, blue: 0.965, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    private let nameField = NameField(
        label: "auth.email.label".localized,
        placeholder:"auth.email.placeholder".localized
    )
    
    private let passwordField = PasswordField(
        label: "auth.password.label".localized,
        placeholder: "auth.password.placeholder".localized
    )
    private let navigationStackView = NavigationStackView()
    private let bottomButtonsStackView = BottomButtonsStackView()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            applicationLogo,
            createVerticalSpace(90),
            nameField,
            createVerticalSpace(40),
            passwordField,
            createVerticalSpace(16),
            navigationStackView
        ])
        
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setVCBackground()
        setupContentStackLayout()
        setupButtonStackLayout()
        setupButtonActions()
        
        setupLocalizationObserver()
        setupTapToDismissKeyboard()
    }
    
    private func setupContentStackLayout() {
        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupButtonStackLayout() {
        view.addSubview(bottomButtonsStackView)
        bottomButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    private func createVerticalSpace(_ height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }
    
    private func setupButtonActions() {
        navigationStackView.onSignUpTapped = { [weak self] in
            self?.viewModel.signUpButtonTapped()
        }
        
        bottomButtonsStackView.onGoogleButtonTapped = { [weak self] in
            guard let strongSelf = self else { return }
            
            self?.viewModel.googleButtonTapped(viewController: strongSelf)
        }
        
        bottomButtonsStackView.onSubmitLoginTapped = { [weak self] in
            guard let self = self else { return }
            
            let email = self.nameField.textField.text ?? ""
            let password = self.passwordField.textField.text ?? ""
            
            self.viewModel.loginButtonTapped(from: self, emailValue: email, passwordValue: password)
        }
    }
}

extension LoginViewController: Localizable {
    func updateLocalizedStrings() {
        nameField.updateLanguage(
            label: "auth.email.label".localized,
            placeholder: "auth.email.placeholder".localized
        )
        passwordField.updateLanguage(
            label: "auth.password.label".localized,
            placeholder: "auth.password.placeholder".localized
        )
        
        navigationStackView.updateLanguage(
            question: "auth.new.user".localized,
            signUp: "auth.signup.button".localized
        )
        
        bottomButtonsStackView.updateLanguage(
            googleLabel: "auth.google.button".localized,
            loginLabel: "auth.login.button".localized
        )
    }
}
