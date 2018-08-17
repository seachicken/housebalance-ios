//
//  TopViewModelTests.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/01.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import RxSwift
import XCTest
@testable import HouseBalance

class TopViewModelTests: XCTestCase {
  var disposeBag: DisposeBag!

  override func setUp() {
    super.setUp()

    AppEnvironment.settings = MockKeyValueStore()
    self.disposeBag = DisposeBag()
  }

  func test必須項目が全て入力されると確定ボタンを有効化する() {
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "有効状態が出力されること")

    viewModel.inputs.salaryChanged("1")
    viewModel.inputs.pickerView(didSelectRow: 1)

    viewModel.outputs.isValid
      .subscribe(onNext: {
        XCTAssertEqual(true, $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }

  func test月収欄に1億を超える値が入った場合は確定ボタンを無効化する() {
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "無効状態が出力されること")

    viewModel.inputs.salaryChanged("10000")
    viewModel.inputs.pickerView(didSelectRow: 1)

    viewModel.outputs.isValid
      .subscribe(onNext: {
        XCTAssertEqual(false, $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }

  func test月収欄に数値以外が入った場合は確定ボタンを無効化する() {
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "無効状態が出力されること")

    viewModel.inputs.salaryChanged("a")
    viewModel.inputs.pickerView(didSelectRow: 1)

    viewModel.outputs.isValid
      .subscribe(onNext: {
        XCTAssertEqual(false, $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }

  func test家族構成欄が未設定の場合は確定ボタンを無効化する() {
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "無効状態が出力されること")

    viewModel.inputs.salaryChanged("1")
    viewModel.inputs.pickerView(didSelectRow: 0)

    viewModel.outputs.isValid
      .subscribe(onNext: {
        XCTAssertEqual(false, $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }

  func test初回起動時に月収欄が空白であること() {
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "空白が出力されること")

    viewModel.outputs.salaryText
      .subscribe(onNext: {
        XCTAssertEqual("", $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }

  func test次回以降の起動時は月収欄に前回値が設定されていること() {
    AppEnvironment.settings.salary = Salary(1)
    let viewModel = TopViewModel()
    let expectation = XCTestExpectation(description: "前回値が出力されること")

    viewModel.outputs.salaryText
      .subscribe(onNext: {
        XCTAssertEqual("1", $0)
        expectation.fulfill()
      })
      .disposed(by: self.disposeBag)

    wait(for: [expectation], timeout: 1)
  }
}
