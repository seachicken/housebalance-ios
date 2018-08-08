//
//  AppEnvironmentTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/10.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class AppEnvironmentTests: XCTestCase {
  override func setUp() {
    super.setUp()

    AppEnvironment.settings = MockKeyValueStore()
  }

  func test月収を更新() {
    XCTAssertEqual(Salary(0), AppEnvironment.settings.salary)

    AppEnvironment.settings.salary = Salary(1)

    XCTAssertEqual(Salary(1), AppEnvironment.settings.salary)
  }

  func test家族構成を更新() {
    XCTAssertEqual(.none, AppEnvironment.settings.familyStructure)

    AppEnvironment.settings.familyStructure = .single

    XCTAssertEqual(.single, AppEnvironment.settings.familyStructure)
  }
}
