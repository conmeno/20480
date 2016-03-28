//
//  AdManagerView.swift
//  Gummy Fighter
//
//  Created by Phuong Nguyen on 2/4/16.
//  Copyright © 2016 PhuongNguyen. All rights reserved.
//

import Foundation
import UIKit



class AdManagerView: UIViewController
{
    
    
    //    var isAd1 = true//admob full
    //    var isAd2 = false//charbootst
    //    var isAd3 = false//auto chartboost
    //    var isAd4 = true//admob banner
    //    var isAd5 = false//adcolony
    //    var isAd6 = true//amazon
    //    var isAd7 = true//Admob Edit
    //    var isAd8 = true//ChartBoost Edit
    
    @IBOutlet weak var sw1: UISwitch!
    
    @IBOutlet weak var sw2: UISwitch!
    
    @IBOutlet weak var sw3: UISwitch!
    
    @IBOutlet weak var sw4: UISwitch!
     @IBOutlet weak var sw5: UISwitch!
     @IBOutlet weak var sw6: UISwitch!
    
  @IBOutlet weak var ShowOtherAd: UISwitch!
    
    @IBOutlet weak var CheckAdOnline: UISwitch!
    
    @IBOutlet weak var textDevice: UITextView!
    
    @IBAction func sw1Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad1")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd1 = sender.on
        
    }
    
    @IBAction func sw2Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad2")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd2 = sender.on
    }
    
    
    @IBAction func sw3Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad3")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd3 = sender.on
    }
    
    
    @IBAction func sw4Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad4")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd4 = sender.on
    }
    
    @IBAction func sw5Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad5")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd5 = sender.on
    }
    
    
    @IBAction func sw6Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad6")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd6 = sender.on
    }
    
       
    @IBAction func ShowOtherAd(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"show-other-ad")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.showOtherAd = sender.on
        if(Utility.showOtherAd)
        {
            NSUserDefaults.standardUserDefaults().setObject("true", forKey:"show-other-ad-online")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
    @IBAction func CheckAdOnlineAction(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"adOnline")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.CheckOnline = sender.on
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheckAdOptionValue()
        setupDevice()
        
    }
    
    
    //    @IBAction func EditGoogle(sender: AnyObject) {
    //        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
    //
    //        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("GoogleAdEditorView") as UIViewController
    //
    //        self.presentViewController(WebDetailView, animated: true, completion: nil)
    //
    //    }
    //    @IBAction func EditChartboost(sender: AnyObject) {
    //        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
    //
    //        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("ChartboostAdEditorView") as UIViewController
    //
    //        self.presentViewController(WebDetailView, animated: true, completion: nil)
    //    }
    
    func setupDevice()
    {
        
        var myIDFA: String = ""
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        
        textDevice.text = "IDFA: \n" + myIDFA + "\nVendorID: \n" + venderID
    }
    func CheckAdOptionValue()
    {
        //        //ad1 admob
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad1") != nil)
        //        {
        //            isAd1 = NSUserDefaults.standardUserDefaults().objectForKey("ad1") as! Bool
        //
        //        }
        //
        //        //ad2 charboost
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad2") != nil)
        //        {
        //            isAd2 = NSUserDefaults.standardUserDefaults().objectForKey("ad2") as! Bool
        //
        //        }
        //
        //
        //        //ad3 ...
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        //        {
        //            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
        //
        //        }
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        //        {
        //            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
        //
        //        }
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad5") != nil)
        //        {
        //            isAd5 = NSUserDefaults.standardUserDefaults().objectForKey("ad5") as! Bool
        //
        //        }
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad6") != nil)
        //        {
        //            isAd6 = NSUserDefaults.standardUserDefaults().objectForKey("ad6") as! Bool
        //
        //        }
        //
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad7") != nil)
        //        {
        //            isAd7 = NSUserDefaults.standardUserDefaults().objectForKey("ad7") as! Bool
        //
        //        }
        //
        //        if(NSUserDefaults.standardUserDefaults().objectForKey("ad8") != nil)
        //        {
        //            isAd8 = NSUserDefaults.standardUserDefaults().objectForKey("ad8") as! Bool
        //            
        //        }
        
        sw1.on = Utility.isAd1
        sw2.on = Utility.isAd2
        sw3.on = Utility.isAd3
        sw4.on = Utility.isAd4
         ShowOtherAd.on = Utility.showOtherAd
        CheckAdOnline.on = Utility.CheckOnline
        
    }
    
    
}
