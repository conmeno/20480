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
    var isShowFullAdmob = false
    
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
        
        let options = AmazonAdOptions()
        options.isTestRequest = false
        let x = (self.view.bounds.width - 320)/2
        
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
    func isCDMA()->Bool
    {
        let abc = cclass()
        let Version = abc.platformNiceString()
        if(Version == "CDMA")
        {
            return true
        }
        
        return false
    }
   
    


func timerMethodAutoAmazon(timer:NSTimer) {
    print("auto load amazon")
    if(showAd())
    {
        
    if(!isShowFullAdmob)
    {
        showAdmob()
    }
        
    }
    loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
    if(isAutoAmazonFull){
        showAmazonFull()
    }
}

    func showAdcolony()
    {
     AdColony.playVideoAdForZone("vz00bc85ddf0c4471eba", withDelegate: nil)
    }
   
    var interstitial: GADInterstitial!
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: "ca-app-pub-8053657021933536/6361580801")
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "5c3e42c53757129ab442982a11b986b8"]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
            isShowFullAdmob = true
        }
    }
    func ShowAdmobBanner()
    {
        //gBannerView = GADBannerView(frame: CGRectMake(0, 20 , 320, 50))
        gBannerView?.adUnitID = "ca-app-pub-8053657021933536/4884847605"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , "5c3e42c53757129ab442982a11b986b8"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    func showAds()
    {
        
        Chartboost.showInterstitial("Level " + String(AdNumber))
        Chartboost.load()
        AdNumber++
       
        if(AdNumber > 10)
        {
            timerAd?.invalidate()
            //adView.backgroundColor = UIColor.redColor()
        }
        print(AdNumber)
    }
    func timerMethodAutoAd(timer:NSTimer) {
        print("auto play")
       // adView.backgroundColor = UIColor.redColor()
        
       //showAds()
        Chartboost.closeImpression()
        
        //Chartboost.load()
        showAds()
        showAdcolony()
    }

 
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        gBannerView?.hidden = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
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
        if(showAd())
        {
            ShowAdmobBanner()
            self.interstitial = self.createAndLoadAd()
            showAdmob()
            showAds()

        }
     
        //startAppAd = STAStartAppAd()
        //show startApp Full
        if(isCDMA())
        {
            showAdcolony()
            showAmazon()
            self.timerAd = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
            
            interstitialAmazon = AmazonAdInterstitial()
            interstitialAmazon.delegate = self
            loadAmazonFull()
            
            self.timerAd = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
        }
        
      
        
      
    }
    
    func loadAmazonFull()
    {
        let options = AmazonAdOptions()
        
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
        Swift.print("Interstitial loaded.", terminator: "")
        //loadStatusLabel.text = "Interstitial loaded."
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
        print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        print("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        print("Ad has collapsed")
    }


}

