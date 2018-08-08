//
//  Salary.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/13.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

struct Salary {
  let value: Int

  init(_ value: Int) {
    self.value = value
  }

  func calculateAt(_ expense: Expense) -> Int {
    return self.value * expense.rate * 100
  }
}

extension Salary: Equatable {
  static func == (lhs: Salary, rhs: Salary) -> Bool {
    return lhs.value == rhs.value
  }
}
