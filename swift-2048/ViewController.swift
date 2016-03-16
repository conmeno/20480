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
        
 
        
         }
   
    
    
   
  @IBAction func startGameButtonTapped(sender : UIButton) {
    //RandomThemeMusic("4")
    let game = NumberTileGameViewController(dimension: 4, threshold: 10240)
    self.presentViewController(game, animated: true, completion: nil)
  }
    
    
    

}

