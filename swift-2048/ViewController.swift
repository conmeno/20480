//
//  ViewController.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController, ChartboostDelegate,GADBannerViewDelegate,AmazonAdInterstitialDelegate,GADInterstitialDelegate {
    
     var timerAd:NSTimer?
    var AdNumber = 0
    var audioPlayer: AVAudioPlayer?
    var interstitialAmazon: AmazonAdInterstitial!

    
   var gBannerView: GADBannerView!
    var startAppBanner: STABannerView?
    var startAppAd: STAStartAppAd?
    
    var timerVPN:NSTimer?
    var timerAdmobFull:NSTimer?
    var isStopAD = true
    
    
    var interstitial: GADInterstitial!
    var isShowFullAdmob = false
    var isShowFllAmazon = false
    
    func createAndLoadAd() -> GADInterstitial
    {
        var ad = GADInterstitial(adUnitID: "ca-app-pub-7800586925586997/9091572464")
        //ad.delegate = self
        var request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "66a1a7a74843127e3f26f6e826d13bbd"]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    func ShowAdmobBanner()
    {
        var w = view?.bounds.width

        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w!, 50))
        gBannerView?.adUnitID = "ca-app-pub-7800586925586997/7614839264"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        var request = GADRequest()
        request.testDevices = [kGADSimulatorID , "a2be35bd5c1489db37f4327e6727df18"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
    {
        var abc = Test()
        var VPN = abc.isVPNConnected()
        var Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }
    
    
    
    func showAds()
    {
        
        Chartboost.showInterstitial("Home" + String(AdNumber))
        
        AdNumber++
       
        if(AdNumber > 7)
        {
            //adView.backgroundColor = UIColor.redColor()
        }
        println(AdNumber)
    }
    func timerMethodAutoAd(timer:NSTimer) {
        println("auto play")
       // adView.backgroundColor = UIColor.redColor()
        
       showAds()
        
    }

 
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        println("adViewDidReceiveAd:\(view)");
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        println("\(view) error:\(error)")
        gBannerView?.hidden = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        println("adViewWillPresentScreen:\(adView)")
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        println("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        println("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    @IBAction func hover(sender: AnyObject) {
        //auto
        showAdmob()
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
    }
    
    

    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        showAdmob()
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
        showAmazonFull()

        startAppAd!.loadAd()
        
        println("xxaa")
        
            }
    
    @IBAction func Click(sender: AnyObject) {
        showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        
        if (startAppBanner == nil) {
            startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, withDelegate: nil);
            self.view.addSubview(startAppBanner!)
        }
    }
    
    //end click button
    
    func LoadMultiAD()
    {
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitialAmazon = AmazonAdInterstitial()
        
        interstitialAmazon.delegate = self
        
        
        startAppAd = STAStartAppAd()
        //show startApp Full
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        self.timerAdmobFull = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAdmobFull:", userInfo: nil, repeats: true)

        
        
        if(showAd())
        {
            ShowAdmobBanner()
            self.interstitial = self.createAndLoadAd()
            //self.interstitial.delegate = self
            isStopAD = false
        }
        LoadAmazon()
        
    }
     func timerAdmobFull(timer:NSTimer) {
        
       
        if(!isShowFullAdmob)
        {
            
           if(self.interstitial.isReady)
           {
            showAdmob()
            isShowFullAdmob = true;
            }
            
            
        
            
        }
        if(!isShowFllAmazon)
        {
            if(self.interstitialAmazon.isReady){
                
                showAmazonFull()
                isShowFllAmazon = true;
            }
        }
    }
    func timerVPNMethodAutoAd(timer:NSTimer) {
        println("VPN Checking....")
        var isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            println("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            println("Stop showing Ad from admob......")
        }
    }
    

  @IBAction func startGameButtonTapped(sender : UIButton) {
    let game = NumberTileGameViewController(dimension: 4, threshold: 20480)
    self.presentViewController(game, animated: true, completion: nil)
  }
    
    
    
    //amazon full
    //amaazon
    func LoadAmazon()
    {
        var options = AmazonAdOptions()
        
        options.isTestRequest = true
        
        interstitialAmazon.load(options)
    }
    
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }
    
    
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.")
        //loadStatusLabel.text = "Interstitial loaded."
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.")
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        LoadAmazon()
    }
    
    //admob full delegate
    // MARK: GADInterstitialDelegate implementation
    
    func interstitialDidFailToReceiveAdWithError (
        interstitial: GADInterstitial,
        error: GADRequestError) {
            println("interstitialDidFailToReceiveAdWithError: %@" + error.localizedDescription)
    }
    func interstitialWillPresentScreen(interstitial: GADInterstitial)
    {
         println("dashowxxx")
        isShowFullAdmob = true
    }
    
    func interstitialDidDismissScreen (interstitial: GADInterstitial) {
        println("interstitialDidDismissScreen")
       // startNewGame()
    }
}

