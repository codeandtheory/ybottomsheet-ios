//
//  BottomSheetController+Enums.swift
//  YBottomSheet
//
//  Created by Dev Karan on 25/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

internal extension BottomSheetController {
    /// Priorities for various non-required constraints.
    enum Priorities {
        static let panGesture = UILayoutPriority(775)
        static let idealContentSize = UILayoutPriority(251)
        static let sheetCompressionResistance = UILayoutPriority.defaultLow
    }

    /// Types of content that can populate a bottom sheet
    enum Content {
        case view(title: String, view: UIView)
        case controller(_: UIViewController)
    }
}
