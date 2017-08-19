//
//  TopViewModel.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/01.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import RxSwift

protocol TopViewModelInputs {
  func salaryChanged(_ text: String)
  func pickerView(didSelectRow row: Int)
  func doneButtonPressed()
}

protocol TopViewModelOutputs {
  var salaryText: Observable<String> { get }
  var familyStructureText: Observable<String> { get }
  var isValid: Observable<Bool> { get }
}

protocol TopViewModelType {
  var inputs: TopViewModelInputs { get }
  var outputs: TopViewModelOutputs { get }
}

struct TopViewModel: TopViewModelType, TopViewModelInputs, TopViewModelOutputs {
  private let salaryTextVariable = Variable<String>("")
  private let familyStructureValueVariable = Variable<Int>(AppEnvironment.settings.familyStructure.toStoredValue())

  init() {
    let storedSalary = AppEnvironment.settings.salary.value
    if storedSalary > 0 {
      self.salaryTextVariable.value = storedSalary.description
    }
  }

  func salaryChanged(_ text: String) {
    self.salaryTextVariable.value = text
  }
  func pickerView(didSelectRow row: Int) {
    self.familyStructureValueVariable.value = row
  }
  func doneButtonPressed() {
    AppEnvironment.settings.salary = Salary(Int(self.salaryTextVariable.value)!)
    AppEnvironment.settings.familyStructure = .reverseStored(value: self.familyStructureValueVariable.value)
  }

  var salaryText: Observable<String> { return self.salaryTextVariable.asObservable() }
  var familyStructureText: Observable<String> {
    return self.familyStructureValueVariable.asObservable()
      .map { FamilyStructure.reverseStored(value: $0).description }
  }
  var isValid: Observable<Bool> {
    return Observable.combineLatest(self.salaryText.asObservable(), self.familyStructureValueVariable.asObservable()) {
      guard let salaryValue = Int($0) else { return false }

      return (salaryValue > 0 && salaryValue < 10000) && FamilyStructure.reverseStored(value: $1) != .none
    }
  }

  var inputs: TopViewModelInputs { return self }
  var outputs: TopViewModelOutputs { return self }
}
