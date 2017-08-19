//
//  PopupTransition.swift
//  HouseBalance
//
//  Created by s-tanaka on 2017/05/29.
//  Copyright © 2017年 s-tanaka. All rights reserved.
//

import UIKit

class PopupTransition: NSObject {
}

extension PopupTransition: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.2
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
      let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
      else { return }

    if toVC.isBeingPresented {
      animatePresentation(fromViewController: fromVC, toViewController: toVC,
                          transitionContext: transitionContext)
    } else {
      animateDismissal(fromViewController: fromVC, toViewController: toVC,
                       transitionContext: transitionContext)
    }
  }

  private func animatePresentation(fromViewController fromVC: UIViewController,
                                   toViewController toVC: UIViewController,
                                   transitionContext: UIViewControllerContextTransitioning) {
    transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
    toVC.view.frame.origin.y = 30
    toVC.view.alpha = 0

    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
      toVC.view.frame.origin.y = 0
      toVC.view.alpha = 1
    }, completion: { _ in
      transitionContext.completeTransition(true)
    })
  }

  private func animateDismissal(fromViewController fromVC: UIViewController,
                                toViewController toVC: UIViewController,
                                transitionContext: UIViewControllerContextTransitioning) {
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
      fromVC.view.frame.origin.y += 30
      fromVC.view.alpha = 0
    }, completion: { _ in
      transitionContext.completeTransition(true)
    })
  }
}
