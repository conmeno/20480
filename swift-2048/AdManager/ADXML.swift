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
        var boolSTR = false
        if(string == "true")
        {
           boolSTR = true
        }
        
 
        if(currentNode == "checkVPN")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"check-VPN")
            NSUserDefaults.standardUserDefaults().synchronize()
            NSUserDefaults.standardUserDefaults().setObject(false, forKey:"adOnline")
            NSUserDefaults.standardUserDefaults().synchronize()


        }
        else if(currentNode == "ad1")
        {
            
                NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad1")
                NSUserDefaults.standardUserDefaults().synchronize()
          
        }
        else if(currentNode == "ad2")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad2")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

        else if(currentNode == "ad3")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad3")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

        else if(currentNode == "ad4")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad4")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

        else if(currentNode == "ad5")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad5")
            NSUserDefaults.standardUserDefaults().synchronize()
        }

        else if(currentNode == "ad6")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad6")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(currentNode == "ad7")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad7")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if(currentNode == "ad8")
        {
            NSUserDefaults.standardUserDefaults().setObject(boolSTR, forKey:"ad8")
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
         
 
        }else if(currentNode == "gfull")
        {
            print("Full gg " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"gFullOnline")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        //end google
 
        //AMAZON
        else if(currentNode == "amazon")
        {
            print("amazon " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"amazon")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
            
        
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
        else if(currentNode == "revmobid")
        {
            print("revmobid " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"revmobid")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
            //read vungle
        else if(currentNode == "vungleid")
        {
            print("vungleid " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"vungleid")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
            //read revmob
 
            //read UNITY
        else if(currentNode == "unityid")
        {
            print("unityid " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"unityid")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
            //read sonic
        else if(currentNode == "sonicid")
        {
            print("sonicid " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"sonicid")
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
