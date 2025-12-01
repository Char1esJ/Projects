//
//  AuthService.swift
//  firebaseTest
//
//  Created by Charles Janjgava on 11/16/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import UIKit
import Combine

@MainActor
public class AuthService: ObservableObject {
    public static let shared = AuthService()
    
    @Published public private(set) var currentUser: User?
    
    private init() {
        if Auth.auth().currentUser != nil {
            Task {
                await refreshCurrentUser()
            }
        }
    }
    
    public func getCurrentUser() -> User? {
        return currentUser
    }
    
    public func refreshCurrentUser() async {
        await withCheckedContinuation { continuation in
            fetchUser { [weak self] user, error in
                if let user = user {
                    self?.currentUser = user
                }
                continuation.resume()
            }
        }
    }
    
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?)->Void) {
        let fullName = userRequest.fullName
        let userName = ("@\(userRequest.userName)")
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]
            result,
            error in
            
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db
                .collection("users")
                .document(resultUser.uid)
                .setData([
                    "fullname": fullName,
                    "username": userName,
                    "email": email,
                    "password": password
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    Task { @MainActor in
                        await self?.refreshCurrentUser()
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?)->Void) {
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(error)
                return
            } else {
                Task { @MainActor in
                    await self?.refreshCurrentUser()
                }
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userUID).getDocument { [weak self] snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot,
               let snapshotData = snapshot.data(),
               let fullname = snapshotData["fullname"] as? String,
               let username = snapshotData["username"] as? String
            {
                let profileImageName = snapshotData["profileImageName"] as? String
                let user = User(fullname: fullname, username: username, userUID: userUID, profileImageName: profileImageName)
                
                    self?.currentUser = user
                
                completion(user, nil)
            }
        }
    }
    
    public func updateUser(fullname: String, username: String, profileImageName: String? = nil, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
            return
        }
        
        let usernameWithAt = username.hasPrefix("@") ? username : "@\(username)"
        
        var updateData: [String: Any] = [
            "fullname": fullname,
            "username": usernameWithAt
        ]
        
        if let imageName = profileImageName {
            updateData["profileImageName"] = imageName
        }
        
        db.collection("users").document(userUID).updateData(updateData) { [weak self] error in
            if error == nil {
                Task { @MainActor in
                    await self?.refreshCurrentUser()
                }
            }
            completion(error)
        }
    }

    public func configureGoogleSignIn() {
        let clientID = "111005189242-rbju4vb6cs1i4rtql73bvgclr4rlrn9m.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    public func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Error?) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            if let error = error {
                print("Google auth error: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Google auth user sign in error")
                completion(NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get user data"]))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase auth error: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let firebaseUser = authResult?.user else {
                    completion(NSError(domain: "GoogleSignIn", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to get Firebase user"]))
                    return
                }
                
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(firebaseUser.uid)
                
                userRef.getDocument { snapshot, error in
                    if let error = error {
                        print("Firestore fetch error: \(error.localizedDescription)")
                        completion(error)
                        return
                    }
                    
                    if snapshot?.exists != true {
                        let fullname = firebaseUser.displayName ?? "Google User"
                        let username = "@\(firebaseUser.email?.components(separatedBy: "@").first ?? "user")"
                        
                        userRef.setData([
                            "fullname": fullname,
                            "username": username,
                            "email": firebaseUser.email ?? ""
                        ]) { error in
                            if let error = error {
                                print("Firestore save error: \(error.localizedDescription)")
                                completion(error)
                                return
                            }
                            
                            Task { @MainActor in
                                await self?.refreshCurrentUser()
                            }
                            
                            completion(nil)
                        }
                    } else {
                        Task { @MainActor in
                            await self?.refreshCurrentUser()
                        }
                        completion(nil)
                    }
                }
            }
        }
    }
}
