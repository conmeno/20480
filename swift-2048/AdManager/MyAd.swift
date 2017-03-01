//
//  Data.swift
//  Buddha2
//
//  Created by Phuong Nguyen on 6/9/15.
//  Copyright (c) 2015 Phuong Nguyen. All rights reserved.
//

import Foundation
import GoogleMobileAds

class MyAd:NSObject, GADBannerViewDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate,VungleSDKDelegate {
    
    
    let viewController:UIViewController
    //var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var interstitialAmazon: AmazonAdInterstitial!
    var RewardAdNumber = 1000
    var ad: AdColonyInterstitial?
    var timerVPN:NSTimer?
    var timerAd10:NSTimer?
    var timerAd30:NSTimer? //for all ad
    var timerAutoChartboost:NSTimer?
    var timerAmazon:NSTimer?
    
    var timerStartapp:NSTimer?
    //var timerADcolony:NSTimer?
    
    
    var isFirsAdmob = false
    var isFirstChart = false
    var isApplovinShowed = false
    var amazonLocationY:CGFloat = 20
    var AdmobLocationY: CGFloat = 20
    var AdmobBannerTop = true
    var AmazonBannerTop = false
    var AdNumber = 1
    let data = Data()
    
        var startAppBanner: STABannerView?
        var startAppAd: STAStartAppAd?
    
    
    
    init(root: UIViewController )
    {
        self.viewController = root
        
    }
         func viewDidAppearStartApp() {
    
            //if (startAppBanner == nil) {
                startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Top, withView: self.viewController.view, withDelegate: nil);
                self.viewController.view?.addSubview(startAppBanner!)
            //}
    
        }
    
    func ViewDidload()
    {
       
        
        if(CanShowAd())
        {
            if(Utility.isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
                
                self.timerAd10 = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerAd10Method:", userInfo: nil, repeats: true)
            }
            
            if(Utility.isAd3)
            {
                
                //set up amazon full
                interstitialAmazon = AmazonAdInterstitial()
                interstitialAmazon.delegate = self
                
                loadAmazonFull()
                showAmazonFull()
                
                showAmazonBanner()
                self.timerAmazon = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
                
                
            }

            
            if(Utility.isAd4)
            {
                showAdcolony()
                
            }
            
            
            if(Utility.isAd5)
            {
                //chartboost
                showChartBoost()
            }
            if(Utility.isAd6)
            {
                showChartRewardVideo()
                
            }
            
            if(Utility.isAd7)
            {
                Utility.setupRevmob()
                
            }
            
            
            if(Utility.isAd8)
            {
    
                //startapp
                startAppAd = STAStartAppAd()
                startAppAd?.loadAd()
                startAppAd!.showAd()
            }
            if(Utility.isAd9)
            {
                showVungle()
            }
            if(Utility.isAd4 || Utility.isAd5 || Utility.isAd6 || Utility.isAd9 )
            {
                self.timerAd30 = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerAd30:", userInfo: nil, repeats: true)
            }
            
            
            
            
         
            
            
        }
        
    }
    
    func showChartBoost()
    {
        //Chartboost.closeImpression()
        Chartboost.showInterstitial("Home" + String(AdNumber))
        AdNumber += 1
        print(AdNumber)
    }
    
    func showChartRewardVideo()
    {
        
        Chartboost.showRewardedVideo("rewarded " + String(RewardAdNumber))
        RewardAdNumber += 1
        print(RewardAdNumber)
    }
    
    func vungleSDKwillCloseAdWithViewInfo(viewInfo: [NSObject : AnyObject]!, willPresentProductSheet: Bool) {
        print("cai con me no")
    }
    
 
   
    
    func showVungle()
    {
        
        //let nserr : NSError
        //
       
        
        let sdk = VungleSDK.sharedSDK()
        sdk.delegate = self
        do {
            try sdk.playAd(viewController, withOptions: nil)
        } catch
        {
            print("Invalid Selection.")
        }
    }
    //
    //
    func showAdcolony()
    {
//        AdColony.configureWithAppID(<#T##appID: String##String#>, zoneIDs: <#T##[String]#>, options: <#T##AdColonyAppOptions?#>, completion: <#T##(([AdColonyZone]) -> Void)?##(([AdColonyZone]) -> Void)?##([AdColonyZone]) -> Void#>)
//
        
            AdColony.configureWithAppID(Utility.AdcolonyAppID, zoneIDs: [Utility.AdcolonyZoneID], options: nil,
                completion:{(zones) in
                    
                    //AdColony has finished configuring, so let's request an interstitial ad
                    self.requestInterstitial()
                    
                    //If the application has been inactive for a while, our ad might have expired so let's add a check for a nil ad object
//                    NotificationCenter.default.addObserver(self, selector:#selector(ViewController.onBecameActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
                   }
                    )
                    
                    //Show the user that we are currently loading videos
                   // setLoadingState()
        
        
    }
    
    //begin new adcolony
    func requestInterstitial()
    {
        //Request an interstitial ad from AdColony
        AdColony.requestInterstitialInZone(Utility.AdcolonyZoneID, options:nil,
                                     
                                     //Handler for successful ad requests
            success:{(newAd) in
                
                //Once the ad has finished, set the loading state and request a new interstitial
                newAd.setClose({
                    self.ad = nil
                   
                    //self.setLoadingState()
                    self.requestInterstitial()
                })
                
                //Interstitials can expire, so we need to handle that event also
                newAd.setExpire({
                    self.ad = nil
                    
                    //self.setLoadingState()
                    self.requestInterstitial()
                })
                
                //Store a reference to the returned interstitial object
                self.ad = newAd
                
                //Show the user we are ready to play a video
                //self.setReadyState()
            },
            
            //Handler for failed ad requests
            failure:{(error) in
                NSLog("SAMPLE_APP: Request failed with error: " + error.localizedDescription + " and suggestion: " + error.localizedRecoverySuggestion!)
            }
        )
    }
    
    @IBAction func launchInterstitial(sender: AnyObject)
    {
        //Display our ad to the user
        if let ad = self.ad {
            if (!ad.expired) {
                ad.showWithPresentingViewController(viewController)
            }
        }
    }

    
    
    //end adcolony
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: Utility.GFullAdUnit)
        print(Utility.GFullAdUnit)
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, data.TestDeviceID]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        
        
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(viewController)
            self.interstitial = self.createAndLoadAd()
        }
    }
    
    
    func setupButton(){
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(10, 80, 65, 40)
        button.backgroundColor = UIColor.blackColor()
        let image = UIImage(named: "reload.png")
        button.imageView!.image = image
        button.setTitle("Reset", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        //button.titleLabel?.textColor = UIColor.whiteColor()
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        viewController.view?.addSubview(button)
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        
    }
    
    
    //    func ShowAdmobBanner()
    //    {
    //
    //        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
    //        let w = viewController.view.bounds.width
    //        let h = viewController.view.bounds.height
    //        if(!AdmobBannerTop)
    //        {
    //            AdmobLocationY = h - 50
    //        }
    //        gBannerView = GADBannerView(frame: CGRectMake(0, AdmobLocationY , w, 50))
    //        gBannerView?.adUnitID = Utility.GBannerAdUnit
    //        print(Utility.GBannerAdUnit)
    //        gBannerView?.delegate = self
    //        gBannerView?.rootViewController = viewController
    //         gBannerView?.viewWithTag(999)
    //        viewController.view?.addSubview(gBannerView)
    //
    //        let request = GADRequest()
    //        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
    //        gBannerView?.loadRequest(request)
    //        //gBannerView?.hidden = true
    //
    //    }
    
    
    
    
    
    func timerAd10Method(timer:NSTimer) {
        
        if(self.interstitial!.isReady)
        {
            showAdmob()
            timerAd10?.invalidate()
        }
    }
    //timerADcolony
    func timerAd30(timer:NSTimer) {
        
        if(CanShowAd())
        {
            
            if(Utility.isAd4)
            {
                showAdcolony()
                
            }
            if(Utility.isAd9)
            {
                showVungle()
                
            }
            if(Utility.isAd5)
            {
                showChartBoost()
                
            }
            
            if(Utility.isAd6)
            {
                //chartboost reward
                showChartRewardVideo()            }
            
            if(Utility.isAd8)
            {
                startAppAd!.showAd()
            }
            
            
            
        }
        
        
        
    }
    
    //
    //    func timerVPNMethodAutoAd(timer:NSTimer) {
    //        print("VPN Checking....")
    //        let isAd = Utility.CanShowAd()
    //        if(isAd && Utility.isStopAdmobAD)
    //        {
    //
    //            ShowAdmobBanner()
    //            Utility.isStopAdmobAD = false
    //            print("Reopening Ad from admob......")
    //        }
    //
    //
    //
    ////        if(isAd == false && Utility.isStopAD == false)
    ////        {
    ////            gBannerView.removeFromSuperview()
    ////            Utility.isStopAD = true;
    ////            print("Stop showing Ad from admob......")
    ////        }
    //
    //    }
    
    func hideAdmobBanner()
    {
        gBannerView.hidden = true
        
    }
    
    
    //
    //    func showChartBoost()
    //    {
    //        Chartboost.closeImpression()
    //        Chartboost.showInterstitial("Home" + String(AdNumber))
    //        AdNumber++
    //        print(AdNumber)
    //    }
    //
    
    
    
    //GADBannerViewDelegate
    //    func adViewDidReceiveAd(view: GADBannerView!) {
    //        print("adViewDidReceiveAd:\(view)");
    //        if(!Utility.CanShowAd())
    //        {
    //            view.removeFromSuperview()
    //            Utility.isStopAdmobAD = true
    //            print("Stop showing Ad from admob new func......")
    //        }
    //        //relayoutViews()
    //    }
    //
    //    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
    //        print("\(view) error:\(error)")
    //
    //        //relayoutViews()
    //    }
    //
    //    func adViewWillPresentScreen(adView: GADBannerView!) {
    //        print("adViewWillPresentScreen:\(adView)")
    //
    //        //relayoutViews()
    //    }
    //
    //    func adViewWillLeaveApplication(adView: GADBannerView!) {
    //        print("adViewWillLeaveApplication:\(adView)")
    //    }
    //
    //    func adViewWillDismissScreen(adView: GADBannerView!) {
    //        print("adViewWillDismissScreen:\(adView)")
    //
    //        // relayoutViews()
    //    }
    
    
    
    
    //amazon
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    var amazonAdView: AmazonAdView!
    func showAmazonBanner()
    {
        amazonAdView = AmazonAdView(adSize: AmazonAdSize_320x50)
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        amazonAdView.delegate = nil
        viewController.view.addSubview(amazonAdView)
    }
    
    
    func loadAmazonAdWithUserInterfaceIdiom(userInterfaceIdiom: UIUserInterfaceIdiom, interfaceOrientation: UIInterfaceOrientation) -> Void {
        
        let options = AmazonAdOptions()
        options.isTestRequest = false
        let x = (viewController.view.bounds.width - 320)/2
        //viewController.view.bounds.height - 50
        if (userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            amazonAdView.frame = CGRectMake(x, amazonLocationY, 320, 50)
        } else {
            amazonAdView.removeFromSuperview()
            
            if (interfaceOrientation == UIInterfaceOrientation.Portrait) {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_728x90)
                amazonAdView.frame = CGRectMake((viewController.view.bounds.width-728.0)/2.0, amazonLocationY, 728.0, 90.0)
            } else {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_1024x50)
                amazonAdView.frame = CGRectMake((viewController.view.bounds.width-1024.0)/2.0, amazonLocationY, 1024.0, 50.0)
            }
            viewController.view.addSubview(amazonAdView)
            amazonAdView.delegate = nil
        }
        
        amazonAdView.loadAd(options)
    }
    func timerMethodAutoAmazon(timer:NSTimer) {
        print("auto load amazon")
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        
        //        if(Utility.CanShowAd())
        //        {
        //            showAmazonBanner()
        //        }else
        //        {
        //            amazonAdView.removeFromSuperview()
        //        }
        
        
    }
    //////////////////////
    //amazonfull
    //////////////////////
    func loadAmazonFull()
    {
        let options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
        
    }
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self.viewController)
        
    }
    
    /////////////////////////////////////////////////////////////
    // Mark: - AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return viewController
    }
    
    func adViewDidLoad(view: AmazonAdView!) -> Void {
        
        viewController.view.addSubview(amazonAdView)
    }
    
    func adViewDidFailToLoad(view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        print("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        print("Ad has collapsed")
    }
    ///////////
    //full delegate
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.", terminator: "")
        //loadStatusLabel.text = "Interstitial loaded."
        showAmazonFull()
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.", terminator: "")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.", terminator: "")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.", terminator: "")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.", terminator: "")
        
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.", terminator: "");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        //loadAmazonFull();
    }
    
    
    ////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////
    func CanShowAd()->Bool
    {
        if(!Utility.CheckVPN)
        {
            return true
        }
        else
        {
            let abc = cclass()
            let VPN = abc.isVPNConnected()
            let Version = abc.platformNiceString()
            if(VPN == false && Version == "CDMA")
            {
                return false
            }
        }
        
        return true
    }
    
    
}
