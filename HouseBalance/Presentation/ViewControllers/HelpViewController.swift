//
//  HelpViewController.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/23.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
  static func instantiate() -> HelpViewController {
    return Storyboard.help.instantiate(HelpViewController.self)
  }
}
