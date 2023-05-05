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

    enum Direction {
        case present
        case dismiss
    }

    /// Animation direction (present or dismiss)
    let direction: Direction

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
    /// - Parameters:
    ///   - sheetViewController: the sheet being animated.
    ///   - direction: animation direction
    init(sheetViewController: BottomSheetController, direction: Direction) {
        self.sheetViewController = sheetViewController
        self.direction = direction
        super.init()
    }
}

extension BottomSheetAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch direction {
        case .present:
            return sheetViewController.appearance.presentAnimation.duration
        case .dismiss:
            return sheetViewController.appearance.dismissAnimation.duration
        }
    }

    // Override this method and perform the animations
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(false)
    }
}
