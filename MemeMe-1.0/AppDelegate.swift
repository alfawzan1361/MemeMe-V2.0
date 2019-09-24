//
//  AppDelegate.swift
//  MemeMe-1.0
//
//  Created by AF on 9/12/19.
//  Copyright © 2019 amaf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

