//
//  User.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import UIKit

class User {

    var userLogin: String
    var userFullName: String
    var userAvatar: UIImage
    var userStatus: String
    var userPassword: String
    
    init(userLogin: String, userFullName: String, userAvatar: UIImage, userStatus: String, userPassword: String) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
        self.userPassword = userPassword
    }

}
