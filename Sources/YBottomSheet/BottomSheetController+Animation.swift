//
//  BottomSheetController.swift
//  YBottomSheet
//
//  Created by Dev Karan on 22/31/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension BottomSheetController: UIViewControllerTransitioningDelegate {
    /// Returns the animator for presenting a bottom sheet
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        BottomSheetPresentAnimator(sheetViewController: self)
    }
    
    /// Returns the animator for dismissing a bottom sheet
    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        BottomSheetDismissAnimator(sheetViewController: self)
    }
}
