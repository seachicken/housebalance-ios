//
//  FamilyStructure.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/10.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

// enumの名称を基にplistを読み込むので、ファイル名と一致させる必要がある
enum FamilyStructure: String, CustomStringConvertible {
  case none
  case single
  case singleAndParent
  case marriedCouple
  case marriedCoupleAndLittleChild
  case marriedCoupleAndLittleChild2
  case marriedCoupleAndChild
  case marriedCoupleAndChild2

  static let allValues: [FamilyStructure] = [.none,
                                             .single,
                                             .singleAndParent,
                                             .marriedCouple,
                                             .marriedCoupleAndLittleChild,
                                             .marriedCoupleAndLittleChild2,
                                             .marriedCoupleAndChild,
                                             .marriedCoupleAndChild2]

  var description: String {
    switch self {
    case .none:
      return ""
    case .single:
      return "一人暮らし"
    case .singleAndParent:
      return "親と同居の単身者"
    case .marriedCouple:
      return "夫婦"
    case .marriedCoupleAndLittleChild:
      return "夫婦と小学生以下の子１人"
    case .marriedCoupleAndLittleChild2:
      return "夫婦と小学生以下の子２人"
    case .marriedCoupleAndChild:
      return "夫婦と中・高生の子１人"
    case .marriedCoupleAndChild2:
      return "夫婦と中・高生の子２人"
    }
  }
}

extension FamilyStructure: StoredConvertible {
  typealias StoredType = Int

  func toStoredValue() -> Int {
    return FamilyStructure.allValues.enumerated()
      .first { $0.element == self }
      .map { $0.offset }!
  }

  static func reverseStored(value: Int) -> FamilyStructure {
    return FamilyStructure.allValues.enumerated()
      .first { $0.offset == value }
      .map { $0.element }!
  }
}
