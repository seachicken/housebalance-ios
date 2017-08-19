//
//  Colors.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/22.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit

extension UIColor {
  static func hex(_ value: UInt32) -> UIColor {
    let r = CGFloat((value & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((value & 0xFF00) >> 8) / 255.0
    let b = CGFloat((value & 0xFF)) / 255.0

    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
  }

  static var mainGreen: UIColor {
    return .hex(0x72E4CB)
  }

  static var mainRed: UIColor {
    return .hex(0xFF472E)
  }

  static var background: UIColor {
    return .hex(0xF4F4F4)
  }

  static var gray200: UIColor {
    return .hex(0xE8E8E8)
  }

  static var gray100: UIColor {
    return .hex(0xF0F0F0)
  }
}
