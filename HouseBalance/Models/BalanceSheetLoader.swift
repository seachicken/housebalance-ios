//
//  BalanceSheetLoader.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/07.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import Foundation

class BalanceSheetLoader {
  func load(structure: FamilyStructure) -> BalanceSheet {
    guard let path = Bundle(for: type(of: self))
      .url(forResource: structure.rawValue.uppercaseFirst, withExtension: "plist")
      else { fatalError("リソースが見つからない") }
    guard let balances = NSDictionary(contentsOf: path)?["Balances"] as? [[String: Any]]
      else { fatalError("割合をひとまとめにしたキーが存在しない") }

    return BalanceSheet(expenses: balances
      .flatMap {
        if let key = $0["key"] as? String,
          let value = $0["value"] as? Int {
          return Expense(title: key, rate: value)
        } else {
          return nil
        }
      }
    )
  }
}
