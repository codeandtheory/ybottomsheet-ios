//
//  BottomSheetDismissAnimator.swift
//  YBottomSheet
//
//  Created by Dev Karan on 07/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Performs the sheet dismiss animation.
class BottomSheetDismissAnimator: BottomSheetAnimator {
    /// Initializes a bottom sheet animator.
    /// - Parameter sheetViewController: the sheet being animated.
    required init(sheetViewController: BottomSheetController) {
        super.init(sheetViewController: sheetViewController, direction: .dismiss)
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let sheet = sheetViewController
        let toFinalFrame = transitionContext.finalFrame(for: toViewController)
        var sheetFrame = sheet.sheetView.frame
        sheetFrame.origin.y = toFinalFrame.maxY + (sheet.appearance.elevation?.extent.top ?? 0)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: .beginFromCurrentState
        ) {
            sheet.dimmerView.alpha = 0
        }

        UIView.animate(
            with: sheet.appearance.dismissAnimation
        ) {
            if self.isReduceMotionEnabled {
                sheet.sheetView.alpha = 0
            } else {
                sheet.sheetView.frame = sheetFrame
            }
        } completion: { _ in
            if !transitionContext.transitionWasCancelled {
                fromViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
