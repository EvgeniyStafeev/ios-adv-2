//
//  Checker.swift
//  Navigation
//
//  Created by Евгений Стафеев on 27.01.2023.
//

import UIKit

enum loginError: Error {
    case notCorrect
}


class Checker {
    static let shared = Checker()
    
    private var loginSing: String
    private var passwordSing: String
    
    private init() {
        self.loginSing = "netologia"
        self.passwordSing = "123456"
    }
    
    func checkerCheck(login: String, password: String) -> Result<Bool, loginError> {
        if login == loginSing, password == passwordSing {
            return .success(true)
        }
        else {
            return .failure(.notCorrect)
        }
        
    }
}
