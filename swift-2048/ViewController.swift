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

class ViewController: UIViewController,GADBannerViewDelegate,AmazonAdInterstitialDelegate,GADInterstitialDelegate {
    
     var timerAd:NSTimer?
    var AdNumber = 0
    var audioPlayer: AVAudioPlayer?
    var interstitialAmazon: AmazonAdInterstitial!

    
   var gBannerView: GADBannerView!
//    var startAppBanner: STABannerView?
//    var startAppAd: STAStartAppAd?
    
    var timerVPN:NSTimer?
    
    var isStopAD = true
    
    @IBOutlet weak var textDevice: UITextView!
    
    var interstitial: GADInterstitial!
 
    
    //new funciton
    @IBOutlet weak var AdOption: UIView!
    @IBOutlet weak var AdmobCheck: UISwitch!
    @IBOutlet weak var AmazonCheck: UISwitch!
    @IBOutlet weak var ChartboostCheck: UISwitch!
    
    var isAdmob = true;
    var isAmazon = false
    var isChart = false
    
    var isShowFullAdmob = false
    var isShowFllAmazon = false
    var isShowChartboostFirst = false
    var timerAdmobFull:NSTimer?
    
    //end new funciton
    
    
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: "ca-app-pub-1165859043722140/5008085314")
        //ad.delegate = self
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "ed118f458979010c0f207ec85c5a21fa"]
        
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
        let w = view?.bounds.width
        let h = view?.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, (h! - 50) , w!, 50))
        gBannerView?.adUnitID = "ca-app-pub-1165859043722140/3531352116"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , "ed118f458979010c0f207ec85c5a21fa"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
    {
        let abc = Test()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
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
        print(AdNumber)
    }
    func timerMethodAutoAd(timer:NSTimer) {
        print("auto play")
       // adView.backgroundColor = UIColor.redColor()
        
       showAds()
        
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
        showAdmob()
        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
    }
    
    

    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        showAdmob()
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
        showAmazonFull()

        //startAppAd!.loadAd()
        
        print("xxaa")
        
            }
    
    @IBAction func Click(sender: AnyObject) {
        showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        
        //if (startAppBanner == nil) {
         //   startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, //withDelegate: nil);
            //self.view.addSubview(startAppBanner!)
        //}
        let myIDFA: String?
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        } else {
            myIDFA = nil
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        AdOption.hidden = false
        
        textDevice.text = "IDFA: \n" + myIDFA! + "\nVendorID: \n" + venderID
        
        
    }
    
    //end click button
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
         CheckAdOptionValue()
       
        if(showAd())
        {
            ShowAdmobBanner()
            if(isAdmob)
            {
                
                self.interstitial = self.createAndLoadAd()
            }
            isStopAD = false
        }
        AdOption.hidden = true
        
        
        if(isAmazon)
        {
            interstitialAmazon = AmazonAdInterstitial()
            
            interstitialAmazon.delegate = self
            
            LoadAmazon()
        }
        
        if(showAd())
        {
            ShowAdmobBanner()
            
            self.interstitial = self.createAndLoadAd()
            //self.interstitial.delegate = self
            isStopAD = false
        }
       
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        self.timerAdmobFull = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAdmobFull:", userInfo: nil, repeats: true)
    }
  
    func CheckAdOptionValue()
    {
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Admob") != nil)
        {
            isAdmob = NSUserDefaults.standardUserDefaults().objectForKey("Admob") as! Bool
            
        }
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Amazon") != nil)
        {
            isAmazon = NSUserDefaults.standardUserDefaults().objectForKey("Amazon")as! Bool
            
        }
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Chart") != nil)
        {
            isChart = NSUserDefaults.standardUserDefaults().objectForKey("Chart") as! Bool
            
        }
        AdmobCheck.on = isAdmob
        AmazonCheck.on = isAmazon
        ChartboostCheck.on = isChart
    }
    //Save ADOption
    @IBAction func GoogleChange(sender: UISwitch) {
        //if(AdmobCheck.on)
        //{
        
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Admob")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAdmob = sender.on
        //
        // }
        
    }
    
    @IBAction func AmazonChange(sender: UISwitch) {
        //        if(AmazonCheck.on)
        //        {
        
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Amazon")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAmazon = sender.on
        //}
    }
    
    @IBAction func СhartBoostChanged(sender: UISwitch) {
       
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Chart")
        NSUserDefaults.standardUserDefaults().synchronize()
        isChart = sender.on
        
    }
    func timerAdmobFull(timer:NSTimer) {
        //var isShowFullAdmob = false
        //var isShowFllAmazon = false
        //var isShowChartboostFirst = false
        if(isChart && isShowChartboostFirst == false)
        {
            
            Chartboost.showInterstitial("First stage")
            isShowChartboostFirst = true;
            //timerAdmobFull?.invalidate()
            
            
        }
        if(isAdmob && isShowFullAdmob == false)
        {
            
            if(self.interstitial.isReady)
            {
                showAdmob()
                //timerAdmobFull?.invalidate()
                isShowFullAdmob = true;
            }
        }
        
        if(isAmazon && isShowFllAmazon ==  false)
        {
            if(self.interstitialAmazon.isReady){
                
                showAmazonFull()
                //timerAdmobFull?.invalidate()
                isShowFllAmazon = true
            }
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
    

  @IBAction func startGameButtonTapped(sender : UIButton) {
    let game = NumberTileGameViewController(dimension: 4, threshold: 5120)
    self.presentViewController(game, animated: true, completion: nil)
  }
    
    
    
    //amazon full
    //amaazon
    func LoadAmazon()
    {
        let options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
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
        LoadAmazon()
    }
    
    //admob full delegate
    // MARK: GADInterstitialDelegate implementation
    
    func interstitialDidFailToReceiveAdWithError (
        interstitial: GADInterstitial,
        error: GADRequestError) {
            print("interstitialDidFailToReceiveAdWithError: %@" + error.localizedDescription)
    }
    func interstitialWillPresentScreen(interstitial: GADInterstitial)
    {
         print("dashowxxx")
        isShowFullAdmob = true
    }
    
    func interstitialDidDismissScreen (interstitial: GADInterstitial) {
        print("interstitialDidDismissScreen")
       // startNewGame()
    }
    
    
    //chartboost delegate
 
   
}

