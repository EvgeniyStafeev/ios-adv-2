//
//  UserService.swift
//  Navigation
//
//  Created by Евгений Стафеев on 20.01.2023.
//

import Foundation
import UIKit

protocol UserService {

    func getLogin(userLogin: String, userPassword: String) -> User?

}
