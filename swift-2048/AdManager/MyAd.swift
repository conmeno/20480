//
//  Data.swift
//  Buddha2
//
//  Created by Phuong Nguyen on 6/9/15.
//  Copyright (c) 2015 Phuong Nguyen. All rights reserved.
//

import Foundation
import GoogleMobileAds
class MyAd:NSObject, GADBannerViewDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate, VungleSDKDelegate  {
    
    
    let viewController:UIViewController
    var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var interstitialAmazon: AmazonAdInterstitial!
    var timerVPN:NSTimer?
    var timerAd10:NSTimer?
    //var timerAd30:NSTimer?
    var timerAd60:NSTimer?
    var timerAmazon:NSTimer?
    var timerADcolony:NSTimer?
    
    
    var isFirsAdmob = false
    var isFirstChart = false
    var amazonLocationY:CGFloat = 20.0
    var AdmobLocationY: CGFloat = 20
    var AdmobBannerTop = false
    var AdNumber = 1
    let data = Data()
    
    
    
 
   
    
    init(root: UIViewController )
    {
        self.viewController = root
        
    }
 
    func ViewDidload()
    {
     
        
        if(showAd())
        {
            if(Utility.isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
            }
          
            
            if(Utility.isAd2)
            {
                showChartBoost()
            }
            
            if(Utility.isAd1 || Utility.isAd2)
            {
                self.timerAd10 = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAD10:", userInfo: nil, repeats: true)
            }
            
            
            if(Utility.isAd3)
            {
                self.timerAd60 = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: "timerAD60:", userInfo: nil, repeats: true)
            }
            
            if(Utility.isAd4)
            {
                ShowAdmobBanner()
                self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
            }
            
           
            if(Utility.isAd5)
            {
                showAdcolony()
                self.timerADcolony = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerADcolony:", userInfo: nil, repeats: true)
            }
            
            if(Utility.isAd6)
            {
                showAmazonBanner()
                self.timerAmazon = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
                
                
                //set up amazon full
                interstitialAmazon = AmazonAdInterstitial()
                interstitialAmazon.delegate = self

                loadAmazonFull()
                showAmazonFull()

            }
            
            
          
            
            if(Utility.isAd7)
            {
                Utility.setupRevmob()
            }
            
            if(Utility.isAd8)
            {
                showVungle()
            }
            
            }
        
    }
    
    func showVungle()
    {
        
        
        let sdk = VungleSDK.sharedSDK()
        sdk.delegate = self
        sdk.playAd(viewController, withOptions: nil)
        
       }
//    @IBAction func playAd(sender: AnyObject) {
//        var sdk = VungleSDK.sharedSDK()
//        sdk.delegate = self
//        sdk.playAd(viewController, error: nil)
//    }
    
    func vungleErr()
    {
    
    }
     func showAdcolony()
    {
        AdColony.playVideoAdForZone(Utility.AdcolonyZoneID, withDelegate: nil)
    }
    
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
    
    
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = viewController.view.bounds.width
        let h = viewController.view.bounds.height
        if(!AdmobBannerTop)
        {
            AdmobLocationY = h - 50
        }
        gBannerView = GADBannerView(frame: CGRectMake(0, AdmobLocationY , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = viewController
        viewController.view?.addSubview(gBannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
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
    
    
//    func timerAD30(timer:NSTimer) {
//        if(RevMobAds.session() == nil)
//        {
//            setupRevmob()
//           
//        }else
//        {
//            RevmobFull()
//            RevmobBanner()
//            RevmobVideo()
//        }
//        
//    }
//
    
    func timerAD10(timer:NSTimer) {
        
        if(showAd())
        {
            if(Utility.isAd1 && isFirsAdmob == false)
            {
                if(self.interstitial.isReady)
                {
                    showAdmob()
                    isFirsAdmob = true
                }
            }
            if(Utility.isAd2 && isFirstChart == false)
            {
                Chartboost.showInterstitial("First stage")
                
                isFirstChart = true
            }
        }
        
        if(isFirsAdmob && isFirstChart)
        {
            timerAd10?.invalidate()
        }
        
        
    }
    func timerAD60(timer:NSTimer) {
        
        if(showAd())
        {
            if(Utility.isAd2)
            {
                showChartBoost()
            }
            
        }
        
        
        
    }
    //timerADcolony
    func timerADcolony(timer:NSTimer) {
        
        if(showAd())
        {
           showAdcolony()
            
        }
        
        
        
    }

    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            print("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            print("Stop showing Ad from admob......")
        }
        
    }
    
    func hideAdmobBanner()
    {
        gBannerView.hidden = true
    
    }
    
    
    
    func showChartBoost()
    {
        Chartboost.closeImpression()
        Chartboost.showInterstitial("Home" + String(AdNumber))
        AdNumber++
        print(AdNumber)
    }
    
    
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    
    
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
        if(showAd())
        {
            showAmazonBanner()
        }
        
        
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
    
}
