//
//  SignUpViewController.swift
//  Authentication
//
//  Created by Kristine on 15.11.25.
//

import UIKit
import UIComponents

public class SignUpViewController: UIViewController {
    
    private let viewModel: SignUpViewModel
    
    private let scrollableContent: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fullNameField = NameField(
        label: "auth.fullname.label".localized,
        placeholder: "auth.fullname.placeholder".localized
    )
    private let userNameField = NameField(
        label: "auth.username.label".localized,
        placeholder: "auth.username.placeholder".localized
    )
    private let emailField = NameField(
        label: "auth.email.label".localized,
        placeholder: "auth.email.placeholder".localized
    )
    private let passwordField = PasswordField(
        label: "auth.password.label".localized,
        placeholder: "auth.password.placeholder".localized
    )
    private let ConfirmPasswordField = PasswordField(
        label: "auth.confirm.password.label".localized,
        placeholder: "auth.confirm.password.placeholder".localized
    )
    private let submitSignUpButton = AuthButton(
        label: "auth.signup.title".localized
    )
    
    private lazy var registrationFormStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            fullNameField,
            createVerticalSpace(16),
            userNameField,
            createVerticalSpace(16),
            emailField,
            createVerticalSpace(16),
            passwordField,
            createVerticalSpace(16),
            ConfirmPasswordField
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSignUpButtonLayout()
        setupScrollViewLayout()
        setupFormStackLayout()
        setupButtonActions()
        
        setupLocalizationObserver()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6

        view.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            screenTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupScrollViewLayout() {
        view.addSubview(scrollableContent)
        
        NSLayoutConstraint.activate([
            scrollableContent.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 32),
            scrollableContent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableContent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableContent.bottomAnchor.constraint(equalTo: submitSignUpButton.topAnchor, constant: -16)
        ])
    }
    
    private func setupFormStackLayout() {
        scrollableContent.addSubview(registrationFormStack)
        
        NSLayoutConstraint.activate([
            registrationFormStack.topAnchor.constraint(equalTo: scrollableContent.topAnchor),
            registrationFormStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            registrationFormStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            registrationFormStack.bottomAnchor.constraint(equalTo: scrollableContent.bottomAnchor, constant: -24)
        ])
    }
    
    private func setupSignUpButtonLayout() {
        view.addSubview(submitSignUpButton)
        submitSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitSignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            submitSignUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            submitSignUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            submitSignUpButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonActions() {
        submitSignUpButton.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            
            let fullname = self.fullNameField.textField.text ?? ""
            let username = self.userNameField.textField.text ?? ""
            let email = self.emailField.textField.text ?? ""
            let password = self.passwordField.textField.text ?? ""
            let confirmPassword = self.ConfirmPasswordField.textField.text ?? ""
            
            self.viewModel.signUpButtonTapped(
                from: self,
                fullnameVal: fullname,
                usernameVal: username,
                emailVal: email,
                passwordVal: password,
                confirmPassVal: confirmPassword
            )
            
        }, for: .touchUpInside)
    }
    
    private func createVerticalSpace(_ height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        return spacer
    }
    
}

extension SignUpViewController: Localizable {
    func updateLocalizedStrings() {
        fullNameField.updateLanguage(
                label: "auth.fullname.label".localized,
                placeholder: "auth.fullname.placeholder".localized
            )
        
        userNameField.updateLanguage(
            label: "auth.username.label".localized,
            placeholder: "auth.username.placeholder".localized
        )
        
        emailField.updateLanguage(
            label: "auth.email.label".localized,
            placeholder: "auth.email.placeholder".localized
        )
        
        passwordField.updateLanguage(
            label: "auth.password.label".localized,
            placeholder: "auth.password.placeholder".localized
        )
        
        ConfirmPasswordField.updateLanguage(
            label: "auth.confirm.password.label".localized,
            placeholder: "auth.confirm.password.placeholder".localized
        )
        submitSignUpButton.updateLanguage(
            label: "auth.signup.title".localized
        )
    }
}
