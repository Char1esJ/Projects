//
//  MainCoordinator.swift
//  Core
//
//  Created by kv on 15.11.25.
//

import UIKit

@MainActor
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func startCoordinator()
}

@MainActor
class MainCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public var navigationController = UINavigationController()
    
    public init() {}
    
    func startCoordinator() {
        navigateToLoginPage()
    }
    
    func navigateToLoginPage() {
        let loginViewModel = LoginViewModel(coordinator: self)
        let loginVC = LoginViewController(viewModel: loginViewModel)
        navigationController.setViewControllers([loginVC], animated: false)
    }
    
    func navigateToSignUpPage() {
        let signupViewModel = SignUpViewModel(coordinator: self)
        let signupVC = SignUpViewController(viewModel: signupViewModel)
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    func navigateToChatPage() {
        let chatViewModel = ChatViewModel(coordinator: self)
        let chatVC = ChatViewController(viewModel: chatViewModel)
        navigationController.setViewControllers([chatVC], animated: false)
    }
    
    func navigateToProfilePage() {
        let profileViewModel = ProfileViewModel(coordinator: self)
        let profileVC = ProfileViewController(viewModel: profileViewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
}
