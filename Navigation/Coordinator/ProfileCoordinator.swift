//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Евгений Стафеев on 26.01.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileCoordinator {
 
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startView() {
        
        let currentUserService = CurrentUserService()
        let photoCoordinator = PhotoCoordinator(navigationController: navigationController)
        let profileViewModel = ProfileViewModel(currentUser: currentUserService.user)
        let profileVC = ProfileViewController(photoCoordinator: photoCoordinator, profileViewModel: profileViewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
}
