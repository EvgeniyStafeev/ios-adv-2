//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Евгений Стафеев on 15.11.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func delegateCheck(login: String, password: String) -> Bool
}
