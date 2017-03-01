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
     @IBOutlet weak var sw7: UISwitch!
    @IBOutlet weak var sw8: UISwitch!
    
    @IBOutlet weak var sw9: UISwitch!
    
    @IBOutlet weak var sw10: UISwitch!
    
    @IBOutlet weak var sw11: UISwitch!
    
    @IBOutlet weak var sw12: UISwitch!
    
    @IBOutlet weak var sw13: UISwitch!
    
    @IBOutlet weak var sw14: UISwitch!
    
    
  @IBOutlet weak var CheckVPN: UISwitch!
    
    @IBOutlet weak var CheckAdOnline: UISwitch!
    
    @IBOutlet weak var textDevice: UITextView!

    @IBOutlet weak var txtVersion: UILabel!
    @IBAction func sw1Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad1")
         NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad1")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd1 = sender.on
        
    }
    
    @IBAction func sw2Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad2")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad2")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd2 = sender.on
    }
    
    
    @IBAction func sw3Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad3")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad3")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd3 = sender.on
    }
    
    
    @IBAction func sw4Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad4")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad4")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd4 = sender.on
    }
    
    @IBAction func sw5Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad5")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad5")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd5 = sender.on
    }
    
    
    @IBAction func sw6Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad6")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad6")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd6 = sender.on
    }
    
    
    @IBAction func sw7Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad7")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad7")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd7 = sender.on
    }
    
    @IBAction func sw8Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad8")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad8")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd8 = sender.on
    }
    
    
    
    
    @IBAction func sw9Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad9")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad9")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd9 = sender.on
    }

    @IBAction func sw10Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad10")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad10")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd10 = sender.on
    }
    @IBAction func sw11Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad11")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad11")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd11 = sender.on
    }
    @IBAction func sw12Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad12")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad12")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd12 = sender.on
    }
    @IBAction func sw13Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad13")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad13")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd13 = sender.on
    }
    @IBAction func sw14Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad14")
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"online-ad14")
        NSUserDefaults.standardUserDefaults().synchronize()
        Utility.isAd14 = sender.on
    }
    
    
    
    
    @IBAction func CheckVPN (sender: UISwitch) {
                NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"check-VPN")
                NSUserDefaults.standardUserDefaults().synchronize()
        Utility.CheckVPN = sender.on
//        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"show-other-ad")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        Utility.showOtherAd = sender.on
//        if(Utility.showOtherAd)
//        {
//            NSUserDefaults.standardUserDefaults().setObject("true", forKey:"show-other-ad-online")
//            NSUserDefaults.standardUserDefaults().synchronize()
//
//        }
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
 
        
        sw1.on = Utility.isAd1
        sw2.on = Utility.isAd2
        sw3.on = Utility.isAd3
        sw4.on = Utility.isAd4
        
        sw5.on = Utility.isAd5
        sw6.on = Utility.isAd6
        sw7.on = Utility.isAd7
        sw8.on = Utility.isAd8
        
        
        sw9.on = Utility.isAd9
        sw10.on = Utility.isAd10
        sw11.on = Utility.isAd11
        sw12.on = Utility.isAd12
        sw13.on = Utility.isAd13
        sw14.on = Utility.isAd14
        
        
        

        CheckVPN.on = Utility.CheckVPN
        CheckAdOnline.on = Utility.CheckOnline
        
        txtVersion.text = "Version " + Utility.version
        
    }
    
    
}
