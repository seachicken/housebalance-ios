//
//  SalaryTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/13.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class SalaryTests: XCTestCase {
  func test月収から費目に応じた適正割合を算出する() {
    XCTAssertEqual(3000, Salary(10).calculateAt(Expense(title: "食費", rate: 3)))
    XCTAssertEqual(100, Salary(1).calculateAt(Expense(title: "食費", rate: 1)),
                   "想定される最小桁の確認")
  }
}
