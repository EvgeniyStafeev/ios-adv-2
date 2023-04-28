//
//  LoginInspector.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    
    func delegateCheck(login: String, password: String) -> Bool {
        Navigation.CheckerService.shared.checkCredentials(login: login, password: password)
        if Navigation.CheckerService.shared.isSingIn == true {
            return true
        } else {
            return false
        }
    }
}
