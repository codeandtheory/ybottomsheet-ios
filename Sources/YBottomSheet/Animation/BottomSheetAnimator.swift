//
//  BottomSheetAnimator.swift
//  YBottomSheet
//
//  Created by Dev Karan on 07/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Base class for bottom sheet present and dismiss animators.
class BottomSheetAnimator: NSObject {
    /// Bottom sheet controller.
    let sheetViewController: BottomSheetController

    /// Override for isReduceMotionEnabled. Default is `nil`.
    ///
    /// For unit testing. When non-`nil` it will be returned instead of
    /// `UIAccessibility.isReduceMotionEnabled`,
    var reduceMotionOverride: Bool?

    /// Accessibility reduce motion is enabled or not.
    var isReduceMotionEnabled: Bool {
        reduceMotionOverride ?? UIAccessibility.isReduceMotionEnabled
    }
    
    /// Initializes a bottom sheet animator.
    /// - Parameter sheetViewController: the sheet being animated.
    init(sheetViewController: BottomSheetController) {
        self.sheetViewController = sheetViewController
        super.init()
    }
}

extension BottomSheetAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        sheetViewController.appearance.animationDuration
    }

    // Override this method and perform the animations
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(false)
    }
}
