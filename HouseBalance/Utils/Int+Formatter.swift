//
//  Int+Formatter.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/13.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import Foundation

extension Int {
  var commas: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    return formatter.string(from: self as NSNumber) ?? ""
  }
}
