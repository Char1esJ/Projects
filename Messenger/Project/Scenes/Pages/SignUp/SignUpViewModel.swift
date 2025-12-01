//
//  SignUpViewModel.swift
//  Authentication
//
//  Created by Rize on 15.11.25.
//

import Foundation
import Core
import UIKit
import FirebaseAuth

@MainActor
public class SignUpViewModel {
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
    }
    
    func signUpButtonTapped(
        from viewController: UIViewController,
        fullnameVal: String,
        usernameVal: String,
        emailVal: String,
        passwordVal: String,
        confirmPassVal: String
    ) {
        
        let registerUserRequest = RegisterUserRequest(fullName: fullnameVal, userName: usernameVal, email: emailVal, password: passwordVal, confirmPassword: confirmPassVal)
        
        if passwordVal != confirmPassVal {
            AlertManager.showPasswordsDoNotMatchAlert(on: viewController)
            return
        }
        
        if !Validator.isValidFullName(for: registerUserRequest.fullName) {
            AlertManager.showInvalidFullNameAlert(on: viewController)
            return
        }
        
        if !Validator.isValidUserName(for: registerUserRequest.userName) {
            AlertManager.showInvalidUsernameAlert(on: viewController)
            return
        }
        
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: viewController)
            return
        }
        
        if !Validator.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: viewController)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard self != nil else { return }
            
            Task { @MainActor in
                if let error = error {
                    AlertManager.showRegistrationErrorAlert(on: viewController, with: error)
                    return
                }
                
                if wasRegistered {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
                    }
                } else {
                    AlertManager.showRegistrationErrorAlert(on: viewController)
                }
            }
        }
    }
}
