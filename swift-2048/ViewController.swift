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

class ViewController: UIViewController, ChartboostDelegate,GADBannerViewDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate {
    
    var interstitialAmazon: AmazonAdInterstitial!
     var timerAd:NSTimer?
    var AdNumber = 0
    var audioPlayer: AVAudioPlayer?
    var timerAmazon:NSTimer?
    @IBOutlet weak var gBannerView: GADBannerView!
   // var startAppBanner: STABannerView?
    //var startAppAd: STAStartAppAd?
    var isAutoAmazonFull = false
    
    //begin amazon banner
    
    @IBOutlet var amazonAdView: AmazonAdView!
    func showAmazon()
    {
        amazonAdView = AmazonAdView(adSize: AmazonAdSize_320x50)
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        amazonAdView.delegate = self
        self.view.addSubview(amazonAdView)
    }
     
    
    func loadAmazonAdWithUserInterfaceIdiom(userInterfaceIdiom: UIUserInterfaceIdiom, interfaceOrientation: UIInterfaceOrientation) -> Void {
        
        var options = AmazonAdOptions()
        options.isTestRequest = false
        var x = (self.view.bounds.width - 320)/2
        
        if (userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            amazonAdView.frame = CGRectMake(x, self.view.bounds.height - 50, 320, 50)
        } else {
            amazonAdView.removeFromSuperview()
            
            if (interfaceOrientation == UIInterfaceOrientation.Portrait) {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_728x90)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-728.0)/2.0, self.view.bounds.height - 50, 728.0, 90.0)
            } else {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_1024x50)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-1024.0)/2.0, self.view.bounds.height - 50, 1024.0, 50.0)
            }
            self.view.addSubview(amazonAdView)
            amazonAdView.delegate = self
        }
        
        amazonAdView.loadAd(options)
    }
    
    //end amazon banner
    
    
   
    


func timerMethodAutoAmazon(timer:NSTimer) {
    println("auto load amazon")
    loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
    if(isAutoAmazonFull){
        showAmazonFull()
    }
}


   
//    var interstitial: GADInterstitial!
//    
//    func createAndLoadAd() -> GADInterstitial
//    {
//        var ad = GADInterstitial(adUnitID: "ca-app-pub-7800586925586997/9091572464")
//        
//        var request = GADRequest()
//        
//        request.testDevices = [kGADSimulatorID, "66a1a7a74843127e3f26f6e826d13bbd"]
//        
//        ad.loadRequest(request)
//        
//        return ad
//    }
//    func showAdmob()
//    {
//        if (self.interstitial.isReady)
//        {
//            self.interstitial.presentFromRootViewController(self)
//            self.interstitial = self.createAndLoadAd()
//        }
//    }
    func ShowAdmobBanner()
    {
        //gBannerView = GADBannerView(frame: CGRectMake(0, 20 , 320, 50))
        gBannerView?.adUnitID = "ca-app-pub-7800586925586997/7512154068"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        var request = GADRequest()
        request.testDevices = [kGADSimulatorID , "840f78326dcb34887597a9fa80236814"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    func showAds()
    {
        
        Chartboost.showInterstitial("Home" + String(AdNumber))
        Chartboost.load()
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
        //showAdmob()
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
    }
    
    

    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        //showAdmob()
        showAds()
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
        //startAppAd!.loadAd()
        showAmazonFull()
        isAutoAmazonFull = true
    }
    
    @IBAction func Click(sender: AnyObject) {
        showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        ShowAdmobBanner()
//        if (startAppBanner == nil) {
//            startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, withDelegate: nil);
//            self.view.addSubview(startAppBanner!)
//        }
    }
    
    //end click button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ShowAdmobBanner()
        //self.interstitial = self.createAndLoadAd()
        //startAppAd = STAStartAppAd()
        //show startApp Full
        showAmazon()
        interstitialAmazon = AmazonAdInterstitial()
        
        interstitialAmazon.delegate = self
        loadAmazonFull()
        
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
        Chartboost.load()
    }
    
    func loadAmazonFull()
    {
        var options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }

  @IBAction func startGameButtonTapped(sender : UIButton) {
    //RandomThemeMusic("4")
    let game = NumberTileGameViewController(dimension: 4, threshold: 10240)
    self.presentViewController(game, animated: true, completion: nil)
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
        loadAmazonFull();
    }
    
    
    
    // Mark: - AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(view: AmazonAdView!) -> Void {
        self.view.addSubview(amazonAdView)
    }
    
    func adViewDidFailToLoad(view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        println("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        println("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        println("Ad has collapsed")
    }


}

