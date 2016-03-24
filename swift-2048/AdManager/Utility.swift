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
    static var isAd4 = false//admob banner //ok
    static var isAd5 = false//adcolony      //ok
    static var isAd6 = true//amazon     //ok
    static var isAd7 = false//REvmob    //ok
    static var isAd8 = false//VungLe    /not show
    static var isAd9 = false//Applovin  //ok
    
    static var CheckOnline = true // on/off check ad online
    static var GBannerAdUnit: String = ""
    static var GFullAdUnit: String = ""
    static var ChartboostAppID: String = ""
    static var ChartboostSign: String = ""
    static var AdcolonyAppID: String = ""
    static var AdcolonyZoneID: String = ""
    
    static var Amazonkey = ""
    
    static var RevmobID = ""
    static var VungleID = ""
    
    static var isStopAdmobAD = false
    
    static var showOtherAd = true //showAd (ngoai tru Admob Banner)
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
        
        AdcolonyAppID = data.AdcolonyAppID
        AdcolonyZoneID = data.AdcolonyZoneID
        
        
        VungleID = data.VungleID
        RevmobID = data.RevmobID
        
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
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad9") != nil)
        {
            isAd9 = NSUserDefaults.standardUserDefaults().objectForKey("ad9") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adOnline") != nil)
        {
            Utility.CheckOnline = NSUserDefaults.standardUserDefaults().objectForKey("adOnline") as! Bool
            
        }
        
        
        
        
        
        //GEt Ad unit online
        
        if(Utility.CheckOnline)
        {
        
            let xmlSetup = ADXML()
            xmlSetup.LoadXML()
        }
        SetupAdOnline()
        
        
        
        //setup ad manual
        //SetupAdManual()
        
        
        
        
        
    }
    //    static func SetupAdManual()
    //    {
    //
    //        if(isAd7)
    //        {
    //            if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") != nil)
    //            {
    //                GBannerAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") as! String
    //
    //            }
    //
    //            if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") != nil)
    //            {
    //                GFullAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") as! String
    //            }
    //        }
    //
    //
    //        //get edited appid & sign from Chartboost
    //
    //        if(isAd8)
    //        {
    //            if(NSUserDefaults.standardUserDefaults().objectForKey("CAppID") != nil)
    //            {
    //                ChartboostAppID = NSUserDefaults.standardUserDefaults().objectForKey("CAppID") as! String
    //
    //            }
    //
    //            if(NSUserDefaults.standardUserDefaults().objectForKey("CSign") != nil)
    //            {
    //                ChartboostSign = NSUserDefaults.standardUserDefaults().objectForKey("CSign") as! String
    //
    //            }
    //
    //
    //        }
    //
    //
    //    }
    
    static func SetupAdOnline()
    {
        
        //google
        if(NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") != nil)
        {
            GBannerAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gBannerOnline") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") != nil)
        {
            GFullAdUnit = NSUserDefaults.standardUserDefaults().objectForKey("gFullOnline") as! String
        }
        
        
        //end google
        
        //get edited appid & sign from Chartboost
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("cappidOnline") != nil)
        {
            ChartboostAppID = NSUserDefaults.standardUserDefaults().objectForKey("cappidOnline") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("csignOnline") != nil)
        {
            ChartboostSign = NSUserDefaults.standardUserDefaults().objectForKey("csignOnline") as! String
            
        }
        
        //get edited appid & sign from Adcolony
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") != nil)
        {
            AdcolonyAppID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyAppID") as! String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") != nil)
        {
            AdcolonyZoneID = NSUserDefaults.standardUserDefaults().objectForKey("adcolonyZoneID") as! String
            
        }
        
        //get revmob online id
        if(NSUserDefaults.standardUserDefaults().objectForKey("revmobid") != nil)
        {
            RevmobID = NSUserDefaults.standardUserDefaults().objectForKey("revmobid") as! String
            
        }
        
        
        //get vungle online id
        if(NSUserDefaults.standardUserDefaults().objectForKey("vungleid") != nil)
        {
            VungleID = NSUserDefaults.standardUserDefaults().objectForKey("vungleid") as! String
            
        }
        
        
        //get amazon online id
        if(NSUserDefaults.standardUserDefaults().objectForKey("amazon") != nil)
        {
            Amazonkey = NSUserDefaults.standardUserDefaults().objectForKey("amazon") as! String
            
        }
        
        //get CDMA status
        if(NSUserDefaults.standardUserDefaults().objectForKey("showOtherAd") != nil)
        {
            let tempCDMA = NSUserDefaults.standardUserDefaults().objectForKey("showOtherAd") as! String
            if(tempCDMA == "true")
            {
                showOtherAd = true
            }else
            {
                showOtherAd = false
            }
            
        }
        
        
    }
    
    static func isCDMA()->Bool
    {
        let abc = cclass()
        let Version = abc.platformNiceString()
        if(Version == "CDMA")
        {
            return true
        }
        
        return false
    }
    
    //    static func setupRevmob()
    //    {
    //        //Revmode
    //        let completionBlock: () -> Void = {
    //            RevMobAds.session().showFullscreen();
    //        }
    //        let errorBlock: (NSError!) -> Void = {error in
    //            // check the error
    //            print(error);
    //        }
    //        RevMobAds.startSessionWithAppID("56d28338ac1911bb0a7fd8f8",
    //            withSuccessHandler: completionBlock, andFailHandler: errorBlock);
    //
    //    }
    
    static func setupRevmob()
    {
        
        let completionBlock: () -> Void = {
            RevMobAds.session().showFullscreen()
            
            self.RevmobFull()
            self.RevmobVideo()
            RevmobPopup()
            self.RevmobBanner()
        }
        let errorBlock: (NSError!) -> Void = {error in
            // check the error
            print(error);
        }
        RevMobAds.startSessionWithAppID(Utility.RevmobID,
            withSuccessHandler: completionBlock, andFailHandler: errorBlock);
        
    }
    static func RevmobBanner()
    {
        let banner = RevMobAds.session()?.bannerView()
        banner?.frame = CGRect(x: 0,y: 70,width: 320,height: 50);
        
        RevMobAds.session()?.showBanner();
    }
    static func RevmobFull()
    {
        RevMobAds.session()?.showFullscreen();
    }
    static func RevmobPopup()
    {
        RevMobAds.session()?.showPopup();
        
    }
    static func RevmobVideo()
    {
        //To load
        RevMobAds.session()?.fullscreen().loadVideo()
        
        //To show
        RevMobAds.session()?.fullscreen().showVideo()
    }
    
    static func CanShowAd()->Bool
    {
        let abc = cclass()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        
        return true
    }
    
    
    
    static func MoreGame()
    {
        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
    }
    
    
}
