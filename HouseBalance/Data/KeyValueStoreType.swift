//
//  KeyValueStoreType.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/06.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import Foundation

struct Defaults {
  enum Keys: String {
    case salary
    // Version1.0.2との互換性を考慮し、FamilyStructureではなくHouseholdTypeとする
    case householdType
  }
}

protocol KeyValueStoreType: class {
  func set(_ value: Int, forKey key: String)
  func integer(forKey key: String) -> Int

  var salary: Salary { get set }
  var familyStructure: FamilyStructure { get set }
}

extension KeyValueStoreType {
  var salary: Salary {
    get {
      return Salary(self.integer(forKey: Defaults.Keys.salary.rawValue.uppercaseFirst))
    }
    set {
      self.set(newValue.value, forKey: Defaults.Keys.salary.rawValue.uppercaseFirst)
    }
  }

  var familyStructure: FamilyStructure {
    get {
      let value = self.integer(forKey: Defaults.Keys.householdType.rawValue.uppercaseFirst)
      return FamilyStructure.reverseStored(value: value)
    }
    set {
      self.set(newValue.toStoredValue(), forKey: Defaults.Keys.householdType.rawValue.uppercaseFirst)
    }
  }
}

extension UserDefaults: KeyValueStoreType {
}

class MockKeyValueStore: KeyValueStoreType {
  var store: [String: Any] = [:]

  func integer(forKey key: String) -> Int {
    return self.store[key] as? Int ?? 0
  }

  func set(_ value: Int, forKey key: String) {
    self.store[key] = value
  }
}
