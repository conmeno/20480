//
//  SonicDelegate.swift
//  Conway's GoL
//
//  Created by Phuong Nguyen on 4/22/16.
//  Copyright © 2016 Ilija Tovilo. All rights reserved.
//


class ISDelegate: NSObject {
    /**
     * Called when initiation process of the Interstitial products has finished successfully.
     **/
    func supersonicISInitSuccess(){}
    /**
     * Called each time an initiation stage fails, or if you have a problem in
     * the integration
     * You can learn about the reason by examining the 'error' value
     **/
    func supersonicISInitFailedWithError(error:NSError){ }
    /**
     * Called each time the Interstitial availability state has changed. When available value
     * is YES the next interstitial ad is ready to display, When receiving NO value make sure
     * you don't call the showInterstitial method.
     **/
    func supersonicISAdAvailable(hasAvailableAds:Bool){ }
    /**
     * Called each time the Interstitial window has opened successfully.
     **/
    func supersonicISShowSuccess(){}
    /**
     * Called if showing the Interstitial for the user has failed.
     * You can learn about the reason by examining the ‘error’ value
     **/
    func supersonicISShowFailWithError(error:NSError){ }
    /**
     * Called each time the end user has clicked on the Interstitial ad.
     **/
    func supersonicISAdClicked(){}
    /**
     * Called each time the Interstitial window is about to close
     **/
    func supersonicISAdClosed(){}
    
    func supersonicISAdOpened(){}
    
    func supersonicISFailed(){}
    func supersonicISReady(){}
}