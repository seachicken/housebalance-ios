//
//  SegueIdentifier.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/06.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit

enum Storyboard: String {
  case top
  case result
  case help

  func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
    guard let vc = UIStoryboard.init(name: self.rawValue.uppercaseFirst, bundle: Bundle(for: VC.self))
      .instantiateViewController(withIdentifier: String(describing: VC.self)) as? VC
      else { fatalError("StoryboardからVCを生成できない ID: \(String(describing: VC.self))") }

    return vc
  }
}
