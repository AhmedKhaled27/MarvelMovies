//
//  AppDelegate.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 27/11/2023.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNewRoute()
        return true
    }

}

//MARK: New Route
extension AppDelegate {
    private func setNewRoute() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let splashViewController = UIViewController()
        window?.rootViewController = splashViewController
        
        window?.makeKeyAndVisible()
    }
}
