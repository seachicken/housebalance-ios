//
//  ResultViewModel.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/06.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import RxSwift

protocol ResultViewModelInputs {
  func helpButtonPressed()
  func closeButtonPressed()
}

protocol ResultViewModelOutputs {
  var expenses: Observable<[Expense]> { get }
  var helpViewShown: Observable<Bool> { get }
  var dismiss: Observable<Void> { get }
}

protocol ResultViewModelType {
  var inputs: ResultViewModelInputs { get }
  var outputs: ResultViewModelOutputs { get }
}

struct ResultViewModel: ResultViewModelType, ResultViewModelInputs, ResultViewModelOutputs {
  private let expensesVariable = Variable<[Expense]>(
    BalanceSheetLoader().load(structure: AppEnvironment.settings.familyStructure).expenses)
  private let helpViewShownVariable = Variable<Bool>(false)
  private let dismissEvent = PublishSubject<Void>()

  func helpButtonPressed() {
    self.helpViewShownVariable.value = true
  }
  func closeButtonPressed() {
    self.dismissEvent.onNext(())
  }

  var expenses: Observable<[Expense]> { return self.expensesVariable.asObservable() }
  var helpViewShown: Observable<Bool> { return self.helpViewShownVariable.asObservable() }
  var dismiss: Observable<Void> { return self.dismissEvent }

  var inputs: ResultViewModelInputs { return self }
  var outputs: ResultViewModelOutputs { return self }
}
