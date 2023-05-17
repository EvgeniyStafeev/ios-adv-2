//
//  AppDelegate.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let localNotificationService = LocalNotificationsService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
        print(getDocumentsDirectory())
        
        localNotificationService.registeForLatestUpdatesIfPossible()
        let mainCoordinator: MainCoordinator = MainCoordinatorImp()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator.startApplication()
        window?.makeKeyAndVisible()
        
        
        FirebaseApp.configure()
        return true
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {

        do {
            try Auth.auth().signOut()
        } catch {
            print("Неизвестная ошибка")
        }
    }

    


}

