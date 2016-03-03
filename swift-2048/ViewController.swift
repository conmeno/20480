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

class ViewController: UIViewController {
    
   
      var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var gBannerView: GADBannerView!
   // var startAppBanner: STABannerView?
    //var startAppAd: STAStartAppAd?
    
    @IBAction func hover(sender: AnyObject) {
        //auto
        //showAdmob()
            }
    
    

    
    //click button
    
    @IBAction func moreapp1Click(sender: AnyObject) {
        //showAdmob()
        
    }
    
    @IBAction func moreApp2click(sender: AnyObject) {
        //startAppAd!.loadAd()
        //showAmazonFull()
        //isAutoAmazonFull = true
    }
    
    @IBAction func Click(sender: AnyObject) {
        //showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        //ShowAdmobBanner()
//        if (startAppBanner == nil) {
//            startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, withDelegate: nil);
//            self.view.addSubview(startAppBanner!)
//        }
    }
    
    //end click button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         }
   
  @IBAction func startGameButtonTapped(sender : UIButton) {
    //RandomThemeMusic("4")
    let game = NumberTileGameViewController(dimension: 4, threshold: 10240)
    self.presentViewController(game, animated: true, completion: nil)
  }
    
    
    

}

