//
//  ResultViewController.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/04/30.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import GoogleMobileAds
import RxCocoa
import RxSwift
import UIKit

class ResultViewController: UIViewController {
  @IBOutlet weak var bannerView: GADBannerView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var helpButton: UIButton!

  private let viewModel: ResultViewModelType = ResultViewModel()
  private let disposeBag = DisposeBag()

  static func instantiate() -> ResultViewController {
    return Storyboard.result.instantiate(ResultViewController.self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    bindViewModel()
    bindStyles()

    if !Secrets.isOSS {
      self.bannerView.setUp(adUnitId: Secrets.Firebase.adUnitIDResult,
                            rootViewController: self)
    }

    self.helpButton.rx.tap
      .subscribe(onNext: {
        self.viewModel.inputs.helpButtonPressed()
      })
      .disposed(by: disposeBag)

    self.closeButton.rx.tap
      .subscribe(onNext: {
        self.viewModel.inputs.closeButtonPressed()
      })
      .disposed(by: disposeBag)
  }

  private func bindViewModel() {
    self.viewModel.outputs.expenses
      .bind(to: self.tableView.rx.items(cellIdentifier: "ResultCell")) { (row, element, cell) in
        guard let cell = cell as? ResultCell else {
          fatalError("想定外のCellが指定されている")
        }

        cell.setUp(salary: AppEnvironment.settings.salary, expense: element)
        cell.backgroundColor = row % 2 == 0 ? UIColor.gray100 : UIColor.gray200
      }
      .disposed(by: disposeBag)

    self.viewModel.outputs.helpViewShown
      .filter{ $0 }
      .subscribe(onNext: { [weak self] _ in
        let hvc = HelpViewController.instantiate()
        hvc.transitioningDelegate = self
        hvc.modalPresentationStyle = .custom
        self?.present(hvc, animated: true)
      })
      .disposed(by: self.disposeBag)

    self.viewModel.outputs.dismiss
      .subscribe(onNext: { [weak self] in
        self?.dismiss(animated: true)
      })
      .disposed(by: self.disposeBag)
  }

  private func bindStyles() {
    self.view.backgroundColor = UIColor.background
  }
}

extension ResultViewController: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    return PopupPresentationController(presentedViewController: presented, presenting: presenting,
                                       size: CGSize(width: 300, height: 154))
  }

  func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PopupTransition()
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PopupTransition()
  }
}
