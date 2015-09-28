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

class ViewController: UIViewController, ChartboostDelegate,GADBannerViewDelegate {
    
     var timerAd:NSTimer?
    var AdNumber = 0
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var gBannerView: GADBannerView!
    var startAppBanner: STABannerView?
    var startAppAd: STAStartAppAd?
    func RandomThemeMusic(Mp3Name : String)
    {
        audioPlayer?.stop()
        
        
        let url = NSURL.fileURLWithPath(
            NSBundle.mainBundle().pathForResource(Mp3Name,
                ofType: "mp3")!)
        
        var error: NSError?
        
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        if let err = error {
            println("audioPlayer error \(err.localizedDescription)")
        } else {
            
            audioPlayer?.prepareToPlay()
        }
        audioPlayer?.numberOfLoops = 100
        
    }
    var interstitial: GADInterstitial!
    
    func createAndLoadAd() -> GADInterstitial
    {
        var ad = GADInterstitial(adUnitID: "ca-app-pub-7800586925586997/9091572464")
        
        var request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, "9b1ec7c4a365ca2f239b626a86d2d8f6"]
        
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
        //gBannerView = GADBannerView(frame: CGRectMake(0, 20 , 320, 50))
        gBannerView?.adUnitID = "ca-app-pub-7800586925586997/7614839264"
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        var request = GADRequest()
        request.testDevices = [kGADSimulatorID , "9b1ec7c4a365ca2f239b626a86d2d8f6"];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
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
    
    
    
    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        showAdmob()
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
        startAppAd!.loadAd()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowAdmobBanner()
        self.interstitial = self.createAndLoadAd()
        startAppAd = STAStartAppAd()
        //show startApp Full
        
    }
    

  @IBAction func startGameButtonTapped(sender : UIButton) {
    RandomThemeMusic("4")
    let game = NumberTileGameViewController(dimension: 4, threshold: 20480)
    self.presentViewController(game, animated: true, completion: nil)
  }
}

