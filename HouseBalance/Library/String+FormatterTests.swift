//
//  String+FormatterTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/11.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class StringFormatterTests: XCTestCase {
  func test先頭1文字を大文字にする() {
    XCTAssertEqual("Test", "test".uppercaseFirst)
  }

  func testパーセントの単位を付与() {
    XCTAssertEqual("10%", "10".percent)
  }

  func test円の単位を付与() {
    XCTAssertEqual("10円", "10".yen)
  }

  func test括弧で囲う() {
    XCTAssertEqual("(10)", "10".encloseParentheses)
  }
}
