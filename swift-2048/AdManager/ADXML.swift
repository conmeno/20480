//
//  AdOnline.swift
//  Game10240
//
//  Created by Phuong Nguyen on 3/1/16.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import Foundation




class ADXML: NSObject, NSXMLParserDelegate
{
    var currentNode = ""
    var elementValue: String?
    var success = false
    let data = Data()
    func LoadXML()
    {
        if let url = NSURL(string: data.AdURL)
        {
            if let data = NSData(contentsOfURL: url)
            {
                let parser = NSXMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
        
    }
    
    
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,  attributes attributeDict: [String : String]) {
        
        currentNode = elementName
        
        

    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    if(string != "")
    {
        
        //Show Ad  status
        if(currentNode == "showOtherAd")
        {
            print("showOtherAd status " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"show-other-ad-online")
            NSUserDefaults.standardUserDefaults().synchronize()
            
         

        }

        
        //begin google
        else if(currentNode == "gbanner")
        {
            print("Banner gg " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"gBannerOnline")
            NSUserDefaults.standardUserDefaults().synchronize()
            //chi load xml online lan dau
            //            // sau do set chi so online = false
            NSUserDefaults.standardUserDefaults().setObject(false, forKey:"adOnline")
            NSUserDefaults.standardUserDefaults().synchronize()
 
        }else if(currentNode == "gfull")
        {
            print("Full gg " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"gFullOnline")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        //end google
        //begin chartboost
//        else if(currentNode == "cappid")
//        {
//            print("chartboost App ID" + string)
//            
//            //save to Iphone user
//            
//            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"cappidOnline")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
//        else if(currentNode == "csign")
//        {
//            print("chartboost sign" + string)
//            
//            //save to Iphone user
//            
//            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"csignOnline")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
        //end chartbosot
        
        //begin Adcolony
        else if(currentNode == "adcolonyAppID")
        {
            print("adcolonyAppID " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"adcolonyAppID")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(currentNode == "adcolonyZoneID")
        {
            print("adcolonyZoneID " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"adcolonyZoneID")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        //end adcolony
        //read revmob
//        else if(currentNode == "revmobid")
//        {
//            print("revmobid " + string)
//            
//            //save to Iphone user
//            
//            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"revmobid")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
        
            //read revmob
//        else if(currentNode == "vungleid")
//        {
//            print("vungleid " + string)
//            
//            //save to Iphone user
//            
//            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"vungleid")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
            //read revmob
        else if(currentNode == "amazon")
        {
            print("amazon " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"amazon")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
        
        
        
        
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
     currentNode = ""
        
 
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
}
