//
//  Int+FormatterTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/13.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class IntFormatterTests: XCTestCase {
  func testカンマ区切りで返す() {
    XCTAssertEqual("1,000", 1000.commas, "カンマが1つの場合")
    XCTAssertEqual("1,000,000", 1000000.commas, "カンマが2つの場合")
  }
}
