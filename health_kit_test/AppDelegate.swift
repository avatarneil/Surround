//
//  AppDelegate.swift
//  health_kit_test
//
//  Created by Neil Goldader on 10/19/18.
//  Copyright © 2018 Neil Goldader. All rights reserved.
//

import UIKit
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        let sampleType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)
        
        let query = HKObserverQuery(sampleType: sampleType!, predicate: nil) {query, completionHandler, error in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
            if let vc = self.window?.rootViewController as? ViewController {
                vc.updateData()
                }}
            completionHandler()
        }
        if let vc = self.window?.rootViewController as? ViewController {
            vc.healthStore.execute(query)
//            vc.healthStore.enableBackgroundDelivery(for: sampleType!, frequency: HKUpdateFrequency.immediate, withCompletion: {(success, error) -> Void in
//                if error != nil {
//                    return
//                }
//                if (success) {
//                    vc.updateData()
//                }
//            })
        }
        
        return true
    }
    
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let vc = window?.rootViewController as? ViewController {
//            vc.updateData()
//        }
//        completionHandler(.failed)
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

