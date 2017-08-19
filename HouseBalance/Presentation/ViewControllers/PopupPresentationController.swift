//
//  PopupPresentationController.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/27.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import RxSwift
import UIKit

class PopupPresentationController: UIPresentationController {
  private let disposeBag = DisposeBag()
  private var backgroundView: UIView!
  private let size: CGSize

  init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?,
       size: CGSize) {
    self.size = size
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
  }

  override func presentationTransitionWillBegin() {
    guard let containerView = self.containerView else {
      assertionFailure("想定外のケース、動作条件を要チェック")
      return
    }

    self.backgroundView = UIView(frame: containerView.bounds)
    self.backgroundView.backgroundColor = UIColor.black
    self.backgroundView.alpha = 0
    containerView.insertSubview(self.backgroundView, at: 0)

    let tapBackground = UITapGestureRecognizer()
    tapBackground.rx.event
      .subscribe(onNext: { [weak self] _ in
        self?.presentedViewController.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    self.backgroundView.addGestureRecognizer(tapBackground)

    self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
      self?.backgroundView.alpha = 0.5
    })
  }

  override func dismissalTransitionWillBegin() {
    self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
      self?.backgroundView.alpha = 0
    })
  }

  override func dismissalTransitionDidEnd(_ completed: Bool) {
    if completed {
      self.backgroundView.removeFromSuperview()
    }
  }

  override func size(forChildContentContainer container: UIContentContainer,
                     withParentContainerSize parentSize: CGSize) -> CGSize {
    return self.size
  }

  override var frameOfPresentedViewInContainerView: CGRect {
    guard let containerSize = self.containerView?.bounds.size else {
      assertionFailure("想定外のケース")
      return CGRect.zero
    }

    var rect = CGRect()
    rect.size = size(forChildContentContainer: self.presentedViewController,
                     withParentContainerSize: containerSize)
    rect.origin = CGPoint(x: (containerSize.width - self.size.width) / 2,
                          y: containerSize.height / 2 - rect.size.height / 2)
    return rect
  }

  override func containerViewWillLayoutSubviews() {
    self.presentedView!.frame = self.frameOfPresentedViewInContainerView
  }
}
