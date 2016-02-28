//
//  GoogleAdEditor.swift
//  Spin Hexagon
//
//  Created by Phuong Nguyen on 2/24/16.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import Foundation
import UIKit



class GoogleAdEditor: UIViewController
{
    
    
    
    
    
    @IBOutlet weak var txtAdmobBanner: UITextField!
    
    @IBOutlet weak var txtAdmobFull: UITextField!
     
    @IBAction func CloseForm(sender: AnyObject) {
        Utility.OpenView("AdView1", view: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func LoadData()
    {
         txtAdmobBanner.text = "nil"
        txtAdmobFull.text = "nil"
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") != nil)
        {
            txtAdmobBanner.text = NSUserDefaults.standardUserDefaults().objectForKey("AdmobBannerID") as? String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") != nil)
        {
            txtAdmobFull.text = NSUserDefaults.standardUserDefaults().objectForKey("AdmobFullID") as? String
            
        }
        
        
    }
    @IBAction func ApplyBannerUnit(sender: AnyObject) {
        
        let txt = txtAdmobBanner.text
        if(txt != "")
        {
            NSUserDefaults.standardUserDefaults().setObject(txt, forKey:"AdmobBannerID")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
        
    }
    @IBAction func ApplyFullUnit(sender: AnyObject) {
        let txt = txtAdmobFull.text
        if(txt != "")
        {
            NSUserDefaults.standardUserDefaults().setObject(txt, forKey:"AdmobFullID")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
}
