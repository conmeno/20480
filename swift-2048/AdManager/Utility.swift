//
//  Utility.swift
//  Spin Hexagon
//
//  Created by Phuong Nguyen on 2/25/16.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import Foundation

class Utility {

    static var isAd1 = false//admob full
    static var isAd2 = false//charbootst
    static var isAd3 = false//auto chartboost
    static var isAd4 = true//admob banner
    static var isAd5 = false//adcolony
    static var isAd6 = true//amazon
    static var isAd7 = false//Admob Edit
    static var isAd8 = false//ChartBoost Edit

    
    
    static var GBannerAdUnit: String = ""
    static var GFullAdUnit: String = ""
    static var ChartboostAppID: String = ""
    static var ChartboostSign: String = ""
    
    static var Amazonkey = ""
    
    static func OpenView(viewName: String, view: UIViewController)
    {
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier(viewName) as UIViewController
        
        view.presentViewController(WebDetailView , animated: true, completion: nil)

    }
    
    static func SetUpAdData()
    {
        let data = Data()
        
        GBannerAdUnit = data.gBanner
        GFullAdUnit = data.gFull
        ChartboostAppID = data.cAppID
        ChartboostSign = data.cSign
        Amazonkey = data.AmazonKey
        
        //get edit ad unit ID for Admob
        
        //ad1 admob
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad1") != nil)
        {
            isAd1 = NSUserDefaults.standardUserDefaults().objectForKey("ad1") as! Bool
            
        }
        
        //ad2 charboost
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad2") != nil)
        {
            isAd2 = NSUserDefaults.standardUserDefaults().objectForKey("ad2") as! Bool
            
        }
        
        
        //ad3 ...
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        {
            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad5") != nil)
        {
            isAd5 = NSUserDefaults.standardUserDefaults().objectForKey("ad5") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad6") != nil)
        {
            isAd6 = NSUserDefaults.standardUserDefaults().objectForKey("ad6") as! Bool
            
        }
        
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad7") != nil)
        {
            isAd7 = NSUserDefaults.standardUserDefaults().objectForKey("ad7") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad8") != nil)
        {
            isAd8 = NSUserDefaults.standardUserDefaults().objectForKey("ad8") as! Bool
            
        }

        
        
        if(isAd7)
        {
            if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") != nil)
            {
                GBannerAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") as! String
                
            }
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") != nil)
            {
                GFullAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") as! String
            }
        }
        

        //get edited appid & sign from Chartboost
        
        if(isAd8)
        {
            if(NSUserDefaults.standardUserDefaults().objectForKey("CAppID") != nil)
            {
                ChartboostAppID = NSUserDefaults.standardUserDefaults().objectForKey("CAppID") as! String
                
            }
            
            if(NSUserDefaults.standardUserDefaults().objectForKey("CSign") != nil)
            {
                ChartboostSign = NSUserDefaults.standardUserDefaults().objectForKey("CSign") as! String
                
            }
            

        }
    
    }
    
    
    
    
    
    
    static func MoreGame()
    {
        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }


}
