//
//  PhotoCoordinator.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import Foundation
import UIKit

class PhotoCoordinator {
 
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startView() {
        
        let photoViewController = PhotosViewController()
        photoViewController.title = NSLocalizedString("Photo Gallery", comment: "")
        navigationController.pushViewController(photoViewController, animated: true)
    }
}
