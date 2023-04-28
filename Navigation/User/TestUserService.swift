//
//  TestUserService.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import Foundation
import UIKit

class TestUserService: UserService {
    
    let user: User = .init(userLogin: "1111", userFullName: "Evgeny Stafeev", userAvatar: UIImage(named: "Фото5")!, userStatus: "Учусь в Нетологии", userPassword: "Qw2")

    func getLogin(userLogin: String, userPassword: String) -> User? {
        
        if userLogin == user.userLogin, userPassword == user.userPassword {
            return user
        }
        else {
            print("не правильный логин или пароль")
            return nil
        }
    }

}

