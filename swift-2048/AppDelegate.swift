//
//  AppDelegate.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UnityAdsDelegate {
                            
  var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        
        //============================
        //==========FOR AD============
        //============================
        
        Utility.SetUpAdData()
        if(Utility.isAd3)
        {
        AmazonAdRegistration.sharedRegistration().setAppKey(Utility.Amazonkey)
        AmazonAdRegistration.sharedRegistration().setLogging(true)
        }
        if(Utility.isAd4)
        {
            AdColony.configureWithAppID(Utility.AdcolonyAppID, zoneIDs: [Utility.AdcolonyZoneID], delegate: nil, logging: true)
        }
        if(Utility.isAd7)
        {
            
            let sdk = VungleSDK.sharedSDK()
            // start vungle publisher library
            sdk.startWithAppId(Utility.VungleID)
            sdk.setLoggingEnabled(true)
            sdk.clearCache()
            sdk.clearSleep()
        }
        
        if(Utility.isAd5)
        {
            //UNITY ADS
            UnityAds.sharedInstance().delegate = self
            UnityAds.sharedInstance().setTestMode(true)
            UnityAds.sharedInstance().startWithGameId(Utility.UnityGameID, andViewController: self.window?.rootViewController)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                if UnityAds.sharedInstance().canShow() {
                    UnityAds.sharedInstance().show()
                }
                else {
                    NSLog("%@","Cannot show it yet!")
                }
            }
        }
        
        if(Utility.isAd8)
        {
            let sonicDelegate:ISDelegate  = ISDelegate()
            var myIDFA: String = ""
            // Check if Advertising Tracking is Enabled
            if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
                // Set the IDFA
                myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
            }
            Supersonic.sharedInstance().setISDelegate(sonicDelegate)
            Supersonic.sharedInstance().initISWithAppKey(Utility.SonicID, withUserId: myIDFA)
            Supersonic.sharedInstance().loadIS()
        }
        
        //============================
        //======END FOR AD============
        //============================
        
 
        
        
        return true
    }
    func unityAdsVideoCompleted(rewardItemKey : String, skipped : Bool) {
        NSLog("Video completed: %@: %@", skipped, rewardItemKey)
    }
    
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

