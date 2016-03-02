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
    
    func LoadXML()
    {
        do {
            // var abc = contentsOfURL: NSURL(string: "http://www.tony.somee.com/10240.txt")
            // let g_home_url = String(contentsOfURL: NSURL(string: "http://www.tony.somee.com/10240.txt")!, encoding: NSUTF8StringEncoding, error: nil)
            let jsonData: NSData = NSData(contentsOfURL: NSURL(string: "http://www.tony.somee.com/10240.txt")!)!
            
           //if(jsonData != nil)
            //{
                let parser = NSXMLParser(data: jsonData)
                parser.delegate = self
                parser.parse()
                print("abc")
            //}
           

        
        } catch _ {
            
        }
        
           }
    
    
    
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,  attributes attributeDict: [String : String]) {
        
        currentNode = elementName
        
        

    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
    if(string != "")
    {
        if(currentNode == "gbanner")
        {
            print("Banner gg " + string)
            
            //save to Iphone user
            
            NSUserDefaults.standardUserDefaults().setObject(string, forKey:"gBannerOnline")
            NSUserDefaults.standardUserDefaults().synchronize()
 
        }else if(currentNode == "gfull")
        {
            print("full gg")
            print(string)
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
