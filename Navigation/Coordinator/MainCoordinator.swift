//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

class MainCoordinatorImp: MainCoordinator {
    func startApplication() -> UIViewController {
        return TabBarController()
    }


}
