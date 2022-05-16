//
//  AppDelegate.swift
//  DreamCity
//
//  Created by 1 on 05.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setInitialScreen()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    private func setInitialScreen() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainNavigation")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        if !Application.shared.notInitialApp {
            Application.shared.borders = true
            Application.shared.sound = true
            Application.shared.music = true
            Application.shared.notInitialApp = true
        }
    }
}

