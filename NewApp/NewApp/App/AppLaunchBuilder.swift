//
//  AppLaunchBuilder.swift
//  NewApp
//
//  Created by manjil on 11/24/20.
//

import UIKit
import BaseDesignFramework

final class AppLaunchBuilder {
    static let `default` = AppLaunchBuilder()
   
    private(set) var window: UIWindow?
    
    private lazy var appCoordindator = getAppCoordindator()
    private init() {}
    
    
    func generateApplicationState(with window: UIWindow?) -> Bool {
        self.window = window
          
        appCoordindator.start(with: nil)
        
        return true
    }
    
    private func getAppCoordindator() -> Coordinator {
        guard let window = window else {
            fatalError("No_window")
        }
        
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        return AppCoordinator(route: Route(rootController: navController))
    }
}
