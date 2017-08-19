//
//  FamilyStructureTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/10.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import XCTest
@testable import HouseBalance

class FamilyStructureTests: XCTestCase {
  func test全ての家族構成を取得() {
    XCTAssertEqual([.none,
                    .single,
                    .singleAndParent,
                    .marriedCouple,
                    .marriedCoupleAndLittleChild,
                    .marriedCoupleAndLittleChild2,
                    .marriedCoupleAndChild,
                    .marriedCoupleAndChild2],
                   FamilyStructure.allValues)
  }

  func test家族構成からインデックスに変換() {
    XCTAssertEqual(0, FamilyStructure.none.toStoredValue())
    XCTAssertEqual(1, FamilyStructure.single.toStoredValue())
    XCTAssertEqual(2, FamilyStructure.singleAndParent.toStoredValue())
    XCTAssertEqual(3, FamilyStructure.marriedCouple.toStoredValue())
    XCTAssertEqual(4, FamilyStructure.marriedCoupleAndLittleChild.toStoredValue())
    XCTAssertEqual(5, FamilyStructure.marriedCoupleAndLittleChild2.toStoredValue())
    XCTAssertEqual(6, FamilyStructure.marriedCoupleAndChild.toStoredValue())
    XCTAssertEqual(7, FamilyStructure.marriedCoupleAndChild2.toStoredValue())
  }

  func testインデックスから家族構成に変換() {
    // swiftlint:disable comma
    XCTAssertEqual(.none,                         FamilyStructure.reverseStored(value: 0))
    XCTAssertEqual(.single,                       FamilyStructure.reverseStored(value: 1))
    XCTAssertEqual(.singleAndParent,              FamilyStructure.reverseStored(value: 2))
    XCTAssertEqual(.marriedCouple,                FamilyStructure.reverseStored(value: 3))
    XCTAssertEqual(.marriedCoupleAndLittleChild,  FamilyStructure.reverseStored(value: 4))
    XCTAssertEqual(.marriedCoupleAndLittleChild2, FamilyStructure.reverseStored(value: 5))
    XCTAssertEqual(.marriedCoupleAndChild,        FamilyStructure.reverseStored(value: 6))
    XCTAssertEqual(.marriedCoupleAndChild2,       FamilyStructure.reverseStored(value: 7))
    // swiftlint:enable comma
  }
}
