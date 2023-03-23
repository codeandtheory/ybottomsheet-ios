//
//  BottomSheetPresentAnimator.swift
//  YBottomSheet
//
//  Created by Dev Karan on 07/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Performs the sheet present animation.
class BottomSheetPresentAnimator: BottomSheetAnimator {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let sheet = sheetViewController
        transitionContext.containerView.addSubview(toViewController.view)
        sheet.view.layoutSubviews()
        sheet.dimmerView.alpha = 0
        
        if !isReduceMotionEnabled {
            let toFinalFrame = transitionContext.finalFrame(for: toViewController)
            var sheetFrame = sheet.sheetView.frame
            sheetFrame.origin.y = toFinalFrame.maxY + (sheet.appearance.elevation?.extent.top ?? 0)
            sheet.sheetView.frame = sheetFrame
            sheet.view.setNeedsLayout()
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: .beginFromCurrentState
        ) {
            sheet.dimmerView.alpha = 1
        }
        
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: [.beginFromCurrentState, sheet.appearance.presentAnimationCurve]
        ) {
            sheet.view.layoutIfNeeded()
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
