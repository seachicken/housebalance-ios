//
//  AppDelegate.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/04/29.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if !Secrets.isOSS {
      FIRApp.configure()
      GADMobileAds.configure(withApplicationID: Secrets.Firebase.appID)

      #if !DEBUG
        Fabric.with([Crashlytics.self])
      #endif
    }

    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }
}