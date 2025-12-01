//
//  SceneDelegate.swift
//  Project
//
//  Created by kv on 15.11.25.
//

import UIKit
import FirebaseAuth
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        MainActor.assumeIsolated {
            mainCoordinator = MainCoordinator()
            window?.rootViewController = mainCoordinator?.navigationController
            window?.makeKeyAndVisible()
        }
        
        AuthService.shared.configureGoogleSignIn()
        checkAuthentication(animated: false)
    }
    
    public func checkAuthentication(animated: Bool = true) {
        if animated {
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 0
                } completion: { [weak self] _ in
                    if Auth.auth().currentUser == nil {
                        self?.mainCoordinator?.navigateToLoginPage()
                    } else {
                        self?.mainCoordinator?.navigateToChatPage()
                    }
                    
                    UIView.animate(withDuration: 0.25) {
                        self?.window?.layer.opacity = 1
                    }
                }
            }
        } else {
            if Auth.auth().currentUser == nil {
                mainCoordinator?.navigateToLoginPage()
            } else {
                mainCoordinator?.navigateToChatPage()
            }
        }
    }
}
