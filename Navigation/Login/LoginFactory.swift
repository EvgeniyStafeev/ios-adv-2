//
//  LoginFactory.swift
//  Navigation
//
//  Created by Евгений Стафеев on 04.02.2023.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
