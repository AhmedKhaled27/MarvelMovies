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
        setupNavigationAppearance()
        return true
    }

}

//MARK: New Route
extension AppDelegate {
    private func setNewRoute() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let splashViewController = SplashViewController()
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }

}

//MARK: Appearance
extension AppDelegate {
    func setupNavigationAppearance() {
       if #available(iOS 15, *) {
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.titleTextAttributes = [.foregroundColor: AppColors.color_D83933.color]
           appearance.largeTitleTextAttributes = [.foregroundColor: AppColors.color_D83933.color]
           appearance.backgroundColor = UIColor.white
           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
       } else {
           UINavigationBar.appearance().barTintColor = .white
           UINavigationBar.appearance().tintColor = AppColors.color_D83933.color
           UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.color_D83933.color]
           UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.color_D83933.color]
       }
   }
}
