//
//  AppDelegate.swift
//  TestSearchPhotos
//
//  Created by Alex Balukhtsin on 7.06.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        setupAppearance()
        
        window?.rootViewController = ModulBuilder.createTabBarController()
        return true
    }

    func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                               .font: UIFont.systemFont(ofSize: 34, weight: .semibold)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        appearance.shadowImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
    }
}
