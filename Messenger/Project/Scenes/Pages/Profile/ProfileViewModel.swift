//
//  ProfileViewModel.swift
//  Project
//
//  Created by kv on 15.11.25.
//

import Foundation
import UIKit
import Core

@MainActor
class ProfileViewModel {
    weak var coordinator: MainCoordinator?
    private(set) var currentUser: User?
    var selectedImageName: String?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func logoutTapped(from viewController: UIViewController) {
        AuthService.shared.signOut { [weak self] error in
            guard self != nil else { return }
            
            if let error = error {
                AlertManager.showLogoutError(on: viewController, with: error)
                return
            }
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    func loadProfile(completion: @escaping (User?) -> Void) {
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            
            if error != nil {
                completion(nil)
                return
            }
            
            self.currentUser = user
            completion(user)
        }
    }
    
    func saveUserInfo(fullname: String, username: String, completion: @escaping (Bool, Error?) -> Void) {
        guard !fullname.isEmpty && !username.isEmpty else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid input"])
            DispatchQueue.main.async {
                completion(false, error)
            }
            return
        }
        
        AuthService.shared.updateUser(fullname: fullname, username: username, profileImageName: selectedImageName) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            self.loadProfile { user in
                self.selectedImageName = nil
                DispatchQueue.main.async {
                    completion(user != nil, nil)
                }
            }
        }
    }
}
