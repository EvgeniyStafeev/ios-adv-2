//
//  CheckerService.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import Foundation
import FirebaseAuth
import UIKit

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    static let shared = CheckerService()
    
    var isSingIn: Bool = false
    
    func checkCredentials(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [self] result, error in
            if let error = error {
                print("error: \(error)")
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.userNotFound.rawValue:
                    let alert = UIAlertController(title: "User not found".localized, message: "Do you want to create account?".localized, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: {_ in print("Отказ создания аккаунта")}))
                    alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: {_ in signUp(login: login, password: password)}))
                    UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
                default:
                    AlertErrorSample.shared.alert(alertTitle: "Log in error".localized, alertMessage: error.localizedDescription)
                }
            } else {
                isSingIn = true
            }
        }
    }
    
    func signUp(login: String, password: String) {
            Auth.auth().createUser(withEmail: login, password: password) { result, error in
                if let error = error {
                    AlertErrorSample.shared.alert(alertTitle: "Registration error".localized, alertMessage: error.localizedDescription)
                } else {
                    AlertErrorSample.shared.alert(alertTitle: "Account created".localized, alertMessage: "Account have been created!".localized)
                }
            }
    }
}

