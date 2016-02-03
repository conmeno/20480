//
//  AppearanceProvider.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. All rights reserved.
//

import UIKit

protocol AppearanceProviderProtocol: class {
  func tileColor(value: Int) -> UIColor
  func numberColor(value: Int) -> UIColor
  func fontForNumbers() -> UIFont
}

class AppearanceProvider: AppearanceProviderProtocol {

  // Provide a tile color for a given value
  func tileColor(value: Int) -> UIColor {
    switch value {
    case 5:
      return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    case 10:
      return UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    case 20:
      return UIColor(red: 242.0/255.0, green: 177.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    case 40:
      return UIColor(red: 245.0/255.0, green: 149.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    case 80:
      return UIColor(red: 246.0/255.0, green: 124.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    case 160:
      return UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0)
    case 320, 640, 1280, 2560, 5120, 20480:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    default:
      return UIColor.whiteColor()
    }
  }

  // Provide a numeral color for a given value
  func numberColor(value: Int) -> UIColor {
    switch value {
    case 5, 10:
      return UIColor(red: 119.0/255.0, green: 110.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    default:
      return UIColor.whiteColor()
    }
  }

  // Provide the font to be used on the number tiles
  func fontForNumbers() -> UIFont {
    var fsize:CGFloat = 20.0
    if(isIpad())
    {
        fsize = 40.0;
    }
    if let font = UIFont(name: "HelveticaNeue-Bold", size: fsize) {
      return font
    }
    return UIFont.systemFontOfSize(fsize)
  }
    
    func isIpad()->Bool
    {
        let userInterfaceIdiom = UIDevice.currentDevice().userInterfaceIdiom
        if (userInterfaceIdiom != UIUserInterfaceIdiom.Phone) {
            return true
        }
        return false
    }
}
