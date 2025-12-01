//
//  LoginViewController.swift
//  Assignment-N23
//
//  Created by Charles Janjgava on 10/29/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let profileView = ProfileView()
    let loginView = LoginView()
    let buttonView = ButtonView()
    let viewModel = LoginViewModel()
    
    private var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupButtonAction()
        setupView()
    }
    
    private func setupButtonAction() {
        buttonView.onLoginTapped = { [weak self] in
            self?.savePasswordAndNavigate()
        }
    }
    
    private func savePasswordAndNavigate() {
        let success = viewModel.savePassword(
            username: loginView.userNameField.text,
            password: loginView.passwordField.text,
            confirmPassword: loginView.confirmPasswordField.text
        )
        
        if success {
            navigateToPage()
        }
    }
    
    private func navigateToPage() {
        let quizVC = QuizViewController()
        navigationController?.pushViewController(quizVC, animated: true)
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func setupView() {
        view.addSubview(profileView)
        view.addSubview(loginView)
        view.addSubview(buttonView)
        
        [profileView, loginView, buttonView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 164),
            profileView.heightAnchor.constraint(equalToConstant: 158),
            
            loginView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 25),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 280),
            
            buttonView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 100),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}
