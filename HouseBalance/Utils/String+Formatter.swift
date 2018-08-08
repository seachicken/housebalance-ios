//
//  String+Formatter.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/11.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

extension String {
  var uppercaseFirst: String {
    return String(self.prefix(1)).uppercased() + String(self.dropFirst())
  }

  var percent: String {
    return "\(self)%"
  }

  var yen: String {
    return "\(self)円"
  }

  var encloseParentheses: String {
    return "(\(self))"
  }
}
