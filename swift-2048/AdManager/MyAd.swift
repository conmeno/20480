//
//  Data.swift
//  Buddha2
//
//  Created by Phuong Nguyen on 6/9/15.
//  Copyright (c) 2015 Phuong Nguyen. All rights reserved.
//

import Foundation
import GoogleMobileAds


class MyAd:NSObject, GADBannerViewDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate {
    
    
    let viewController:UIViewController
    //var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var interstitialAmazon: AmazonAdInterstitial!
    //var adcashInterstitial: ADCInterstitial!
   // var myADC=MyADObjectC()
    var timerVPN:NSTimer?
    var timerAd10:NSTimer?
    var timerAd30:NSTimer? //for all ad
    var timerAutoChartboost:NSTimer?
    var timerAmazon:NSTimer?
    var timerCB:NSTimer?
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
    var RewardAdNumber = 1000
    let data = Data()
    
    
    
    init(root: UIViewController )
    {
        self.viewController = root
        
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
            
            
            
            if(Utility.isAd4)
            {
                showAdcolony()
//                self.adcashInterstitial = ADCInterstitial.init(zoneID: "1524017");
//                self.adcashInterstitial.delegate=self;
//                self.adcashInterstitial.load();
                
            //    myADC.viewDidLoad(viewController);
                
                
                

            }
           
            
            
         
            
            
            if(Utility.isAd5)
            {
                 showChartBoost() 
                                self.timerCB = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerCBMethod:", userInfo: nil, repeats: true)
            }
            
            
            if(Utility.isAd6)
            {
                //charboost
                showChartRewardVideo()

            }
            if(Utility.isAd7)
            {
                
                Utility.setupRevmob()
            }
            
           
            if(Utility.isAd8)
            {
                //ADCInterstitial.
                            }
            
            if(Utility.isAd4 || Utility.isAd7 || Utility.isAd8 )
            {
                self.timerAd30 = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: #selector(MyAd.timerAd30(_:)), userInfo: nil, repeats: true)
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
            
            
         
            
            
        }
        
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
    
    
    
    
    
    func timerAd10Method(timer:NSTimer) {
        
        if(self.interstitial!.isReady)
        {
            showAdmob()
            timerAd10?.invalidate()
        }
        
    }

    func timerCBMethod(timer:NSTimer) {
        if(Utility.isAd5)
        {
            showChartBoost()
        }
        if(Chartboost.hasInterstitial("home"))
        {
            timerCB?.invalidate()
        }
    }

    //timerADcolony
    func timerAd30(timer:NSTimer) {
        
        if(CanShowAd())
        {
            
            if(Utility.isAd4)
            {
                
//                self.adcashInterstitial.load();
//                print("load adcash");

            }
//            if(Utility.isAd7)
//            {
//                
//            }
            
            
        }
        
        
        
    }
    
    
    func hideAdmobBanner()
    {
        gBannerView.hidden = true
        
    }
    
    
    
        func showChartBoost()
        {
            //Chartboost.closeImpression()
            
                Chartboost.showInterstitial("home")
                AdNumber += 1
                print(AdNumber)
            
    }
    
    func showChartRewardVideo()
    {
        
        Chartboost.showRewardedVideo("rewarded " + String(RewardAdNumber))
        RewardAdNumber += 1
          print(RewardAdNumber)
    }
    
    
    
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
