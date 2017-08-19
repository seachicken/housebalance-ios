//
//  InputAccessoryView.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/14.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class InputAccessoryView: UIToolbar {
  @IBOutlet weak var doneButton: UIBarButtonItem!

  class func fromNib() -> InputAccessoryView {
    guard let view = UINib(nibName: String(describing: InputAccessoryView.self),
                           bundle: Bundle(for: self))
      .instantiate(withOwner: nil, options: nil).first as? InputAccessoryView
      else { fatalError("Nibファイルが見つからない") }

    return view
  }
}
