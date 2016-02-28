//
//  GoogleAdEditor.swift
//  Spin Hexagon
//
//  Created by Phuong Nguyen on 2/24/16.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import Foundation
import UIKit



class ChartboostAdEditor: UIViewController
{
    
    
    
    @IBOutlet weak var txtAppID: UITextField!
    
    @IBOutlet weak var txtSign: UITextField!
     
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
        txtAppID.text = "nil"
        txtSign.text = "nil"

        if(NSUserDefaults.standardUserDefaults().objectForKey("CAppID") != nil)
        {
            txtAppID.text = NSUserDefaults.standardUserDefaults().objectForKey("CAppID") as? String
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("CSign") != nil)
        {
            txtSign.text = NSUserDefaults.standardUserDefaults().objectForKey("CSign") as? String
            
        }

        
    }
    @IBAction func ApplyChartAppID(sender: AnyObject) {
        
        let txt = txtAppID.text
        if(txt != "")
        {
            NSUserDefaults.standardUserDefaults().setObject(txt, forKey:"CAppID")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
        
    }
    @IBAction func ApplyChartSign(sender: AnyObject) {
        let txt = txtSign.text
        if(txt != "")
        {
            NSUserDefaults.standardUserDefaults().setObject(txt, forKey:"CSign")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
}
