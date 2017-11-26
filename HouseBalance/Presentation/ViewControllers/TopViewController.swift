//
//  TopViewController.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/04/29.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import BubbleTransition
import GoogleMobileAds
import RxCocoa
import RxSwift
import UIKit

class TopViewController: UIViewController {
  @IBOutlet weak var bannerView: GADBannerView!
  @IBOutlet weak var salaryTextField: UITextField!
  @IBOutlet weak var salarySeparatorView: UIView!
  @IBOutlet weak var familyStructureTextField: UITextField!
  @IBOutlet weak var familyStructureSeparatorView: UIView!
  @IBOutlet weak var doneButton: UIButton!

  fileprivate let viewModel: TopViewModelType = TopViewModel()
  fileprivate let allFamilyStructureTexts = FamilyStructure.allValues.map { $0.description }

  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    bindViewModel()
    bindStyles()

    if !Secrets.isOSS {
      self.bannerView.setUp(adUnitId: Secrets.Firebase.adUnitIDTop)
    }

    self.salaryTextField.rx.controlEvent(.editingChanged).asObservable()
      .subscribe(onNext: {
        self.viewModel.inputs.salaryChanged(self.salaryTextField.text!)
      })
      .disposed(by: self.disposeBag)

    let salaryAccessoryView = InputAccessoryView.fromNib()
    salaryAccessoryView.doneButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.familyStructureTextField.becomeFirstResponder()
      })
      .disposed(by: self.disposeBag)
    self.salaryTextField.inputAccessoryView = salaryAccessoryView

    let pickerView = UIPickerView(frame: .zero)
    pickerView.backgroundColor = UIColor.white
    pickerView.dataSource = self
    pickerView.delegate = self
    self.familyStructureTextField.inputView = pickerView

    let familyStructureAccessoryView = InputAccessoryView.fromNib()
    familyStructureAccessoryView.doneButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.view.endEditing(true)
      })
      .disposed(by: self.disposeBag)
    self.familyStructureTextField.inputAccessoryView = familyStructureAccessoryView

    self.doneButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.viewModel.inputs.doneButtonPressed()

        let vc = ResultViewController.instantiate()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self?.present(vc, animated: true)
      })
      .disposed(by: self.disposeBag)

    let tapBackground = UITapGestureRecognizer()
    tapBackground.rx.event
      .subscribe(onNext: { [weak self] _ in
        self?.view.endEditing(true)
      })
      .disposed(by: self.disposeBag)
    view.addGestureRecognizer(tapBackground)
  }

  private func bindViewModel() {
    self.viewModel.outputs.salaryText.asObservable()
      .bind(to: self.salaryTextField.rx.text)
      .disposed(by: self.disposeBag)

    self.viewModel.outputs.familyStructureText.asObservable()
      .bind(to: self.familyStructureTextField.rx.text)
      .disposed(by: self.disposeBag)

    self.viewModel.outputs.isValid
      .subscribe(onNext: { [weak self] isValid in
        self?.doneButton.isEnabled = isValid })
      .disposed(by: self.disposeBag)
  }

  private func bindStyles() {
    self.view.backgroundColor = UIColor.background

    self.salarySeparatorView.backgroundColor = UIColor.mainGreen
    self.salaryTextField.rx.controlEvent(.editingDidBegin).asObservable()
      .subscribe(onNext: {
        self.salarySeparatorView.backgroundColor = UIColor.mainRed
      })
      .disposed(by: self.disposeBag)
    self.salaryTextField.rx.controlEvent(.editingDidEnd).asObservable()
      .subscribe(onNext: {
        self.salarySeparatorView.backgroundColor = UIColor.mainGreen
      })
      .disposed(by: self.disposeBag)

    self.familyStructureSeparatorView.backgroundColor = UIColor.mainGreen
    self.familyStructureTextField.rx.controlEvent(.editingDidBegin).asObservable()
      .subscribe(onNext: {
        self.familyStructureSeparatorView.backgroundColor = UIColor.mainRed
      })
      .disposed(by: self.disposeBag)
    self.familyStructureTextField.rx.controlEvent(.editingDidEnd).asObservable()
      .subscribe(onNext: {
        self.familyStructureSeparatorView.backgroundColor = UIColor.mainGreen
      })
      .disposed(by: self.disposeBag)
  }
}

extension TopViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.allFamilyStructureTexts.count
  }
}

extension TopViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.allFamilyStructureTexts[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.viewModel.inputs.pickerView(didSelectRow: row)
  }
}

extension TopViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transition = BubbleTransition()
    transition.transitionMode = .present
    transition.duration = 0.3
    transition.startingPoint = self.doneButton.center
    transition.bubbleColor = UIColor.background
    return transition
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let transition = BubbleTransition()
    transition.transitionMode = .dismiss
    transition.duration = 0.3
    transition.startingPoint = self.doneButton.center
    transition.bubbleColor = UIColor.background
    return transition
  }
}
