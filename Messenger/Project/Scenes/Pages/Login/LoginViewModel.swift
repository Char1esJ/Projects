//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Kristine on 15.11.25.
//

import Core
import GoogleSignIn
import FirebaseAuth
import UIKit

@MainActor
public class LoginViewModel {
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
    }
    
    func signUpButtonTapped() {
        coordinator?.navigateToSignUpPage()
    }
    
    func loginButtonTapped(from viewController: UIViewController, emailValue: String, passwordValue: String) {
        let loginRequest = LoginUserRequest(email: emailValue, password: passwordValue)
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: viewController)
            return
        }
        
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: viewController)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            
            guard self != nil else { return }
            
            if let error = error {
                AlertManager.showSignInErrorAlert(on: viewController, with: error)
                return
            }
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            } else {
                AlertManager.showSignInErrorAlert(on: viewController)
            }
        }
    }
    
    func googleButtonTapped(viewController: UIViewController) {
        AuthService.shared.signInWithGoogle(presenting: viewController) { [weak self] error in
            guard self != nil else { return }
            
            if let error = error {
                AlertManager.showSignInErrorAlert(on: viewController, with: error)
                return
            }
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            } else {
                AlertManager.showSignInErrorAlert(on: viewController)
            }
        }
    }
}
