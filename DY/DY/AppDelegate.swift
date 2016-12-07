//
//  AppDelegate.swift
//  DY
//
//  Created by 佘红响 on 16/12/6.
//  Copyright © 2016年 佘红响. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = MainTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

