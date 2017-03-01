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

class ViewController: UIViewController ,GADBannerViewDelegate, GADInterstitialDelegate,VungleSDKDelegate {
    
   
      var audioPlayer: AVAudioPlayer?
    
    @IBAction func hover(sender: AnyObject) {
        Utility.OpenView("AdView1",view: self)
        
            }
    
    

    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        Utility.MoreGame()
        
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
       Utility.MoreGame()
        
    }
    
    @IBAction func Click(sender: AnyObject) {
        //showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        
    }
    
    //end click button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            let myad = MyAd(root: self)
            myad.ViewDidload()
            
        
        
        
        if(Utility.isAd2)
        {
            setupDidload()
        }
        
        
         }
   
    
    
   
  @IBAction func startGameButtonTapped(sender : UIButton) {
    //RandomThemeMusic("4")
    let game = NumberTileGameViewController(dimension: 4, threshold: 10240)
    self.presentViewController(game, animated: true, completion: nil)
  }
    
    
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //Begin FOR GOOGLE AD BANNER
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    var timerVPN:NSTimer?
    var gBannerView: GADBannerView!
    func setupDidload()
    {
        
        
        ShowAdmobBanner()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        
    }
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        let h = self.view.bounds.height
        //        if(!AdmobBannerTop)
        //        {
        //            AdmobLocationY = h - 50
        //        }
        gBannerView = GADBannerView(frame: CGRectMake(0, h - 50 , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        gBannerView?.viewWithTag(999)
        self.view?.addSubview(gBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , Utility.AdmobTestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    func CanShowAd()->Bool
    {
        if(!Utility.CheckVPN)
        {
            return true
        }else
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
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = CanShowAd()
        if(isAd && Utility.isStopAdmobAD)
        {
            
            ShowAdmobBanner()
            Utility.isStopAdmobAD = false
            print("Reopening Ad from admob......")
        }
        if(isAd == false && Utility.isStopAdmobAD == false)
        {
            gBannerView.removeFromSuperview()
            Utility.isStopAdmobAD = true;
            print("Stop showing Ad from admob......")
        }
        
        
    }
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //ENDING FOR GOOGLE AD
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    

}

