//
//  StoredConvertible.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/11.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

protocol StoredConvertible {
  associatedtype StoredType

  func toStoredValue() -> StoredType
  static func reverseStored(value: StoredType) -> Self
}
