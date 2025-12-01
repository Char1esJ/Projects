//
//  AlertManager.swift
//  Core
//
//  Created by Charles Janjgava on 11/16/25.
//

import UIKit

public class AlertManager {
    
    public  static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username.")
    }
    
    public static func showInvalidFullNameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid FullName", message: "Please enter a valid fullname.")
    }
}

extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error.localizedDescription)")
    }
}

extension AlertManager {
    
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Error Signing In", message: "\(error.localizedDescription)")
    }
}

extension AlertManager {
    
    public static func showLogoutError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}

extension AlertManager {
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
}

extension AlertManager {
    public static func showPasswordsDoNotMatchAlert(on vc: UIViewController) {
        self.showBasicAlert(
            on: vc,title: "Passwords Don't Match", message: "Both Password Should be the same."
        )
    }
}

extension AlertManager {
    public static func showInvalidInputAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Invalid Input", message: "Please enter valid username and fullname.")
    }
    
    public static func showUpdateError(on vc: UIViewController, with error: Error) {
        self.showBasicAlert(on: vc, title: "Update Error", message: "\(error.localizedDescription)")
    }
    
    public static func showUpdateSuccess(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: "Success", message: "Profile updated successfully.")
    }
}
