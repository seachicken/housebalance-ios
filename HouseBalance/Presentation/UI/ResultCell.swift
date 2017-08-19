//
//  ResultCell.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/10.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var raitoLabel: UILabel!

  func setUp(salary: Salary, expense: Expense) {
    self.titleLabel.text = expense.title
    self.priceLabel.text = salary.calculateAt(expense).commas.yen
    self.raitoLabel.text = expense.rate.description.percent.encloseParentheses
  }
}
