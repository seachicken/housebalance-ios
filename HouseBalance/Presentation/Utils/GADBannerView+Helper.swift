//
//  GADBannerView+Helper.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/08/06.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import GoogleMobileAds

extension GADBannerView {
  func setUp(adUnitId adUnitID: String, rootViewController rootVC: UIViewController? = nil) {
    self.adUnitID = adUnitID
    if rootVC != nil {
      self.rootViewController = rootVC
    }
    let request = GADRequest()
    #if DEBUG
      request.testDevices = [kGADSimulatorID,
                             "b85d5bff495812295dd3726af0b30848"]
    #endif
    self.load(request)
  }
}
