//
//  AppDelegate.swift
//  Holocron
//
//  Copyright (c) 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import Holocron
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        var d = UserDefaults.standard
        var k = KeychainContainer(keychain: Keychain(service: "service"))
        var f = FileContainer(fileProtectionType: .completeUntilFirstUserAuthentication)
        
        let a = "helllooo"
        let b = Something(id: 1)
        
        //defaults
        d["key"] = a
        print(d["key"] ?? "nothing")
        
        d["key2"] = b
        print(d["key2"] ?? "nothing")
        
        //keychain
        k["key"] = a
        print(k["key"] ?? "nothing")
        
        k["key2"] = b
        print(k["key2"] ?? "nothing")
        
        //file
        let s1 = FileContainer.StorageOptions(url: FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first!)
        f[s1] = a
        print(f[s1] ?? "nothing")

        let s2 = FileContainer.StorageOptions(url: FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).last!)
        f[s2] = b
        print(f[s2] ?? "nothing")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

struct Something: Codable, Storable {
    public let id: Int
}

