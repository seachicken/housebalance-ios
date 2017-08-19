//
//  BalanceSheetLoaderTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/07.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class BalanceSheetLoaderTests: XCTestCase {
  var loader: BalanceSheetLoader!

  override func setUp() {
    super.setUp()

    self.loader = BalanceSheetLoader()
  }

  func test一人暮らしのメタデータを読み込む() {
    let data = self.loader.load(structure: .single)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test親と同居の単身者のメタデータを読み込む() {
    let data = self.loader.load(structure: .singleAndParent)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test夫婦のメタデータを読み込む() {
    let data = self.loader.load(structure: .marriedCouple)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test夫婦と小学生以下の子１人のメタデータを読み込む() {
    let data = self.loader.load(structure: .marriedCoupleAndLittleChild)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test夫婦と小学生以下の子２人のメタデータを読み込む() {
    let data = self.loader.load(structure: .marriedCoupleAndLittleChild2)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test夫婦と中・高生の子１人のメタデータを読み込む() {
    let data = self.loader.load(structure: .marriedCoupleAndChild)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }

  func test夫婦と中・高生の子２人のメタデータを読み込む() {
    let data = self.loader.load(structure: .marriedCoupleAndChild2)
    XCTAssertGreaterThanOrEqual(data.expenses.count, 1)
  }
}
