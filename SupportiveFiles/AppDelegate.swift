//
//  AppDelegate.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let viewController = ViewController()
    let assembler =  Assembler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = viewController

        let navViewController = UINavigationController.init(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = navViewController

        window?.makeKeyAndVisible()
        
        assembler.setup(viewController: viewController)
        
        return true
        
       
        
    }
}
