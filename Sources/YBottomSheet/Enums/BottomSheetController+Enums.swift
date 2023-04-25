//
//  BottomSheetController+Enums.swift
//  YBottomSheet
//
//  Created by Dev Karan on 25/04/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

internal extension BottomSheetController {
    /// Priorities for various non-required constraints.
    enum Priorities {
        static let panGesture = UILayoutPriority(775)
        static let sheetContentHugging = UILayoutPriority(751)
        static let sheetCompressionResistanceLow = UILayoutPriority.defaultLow
        static let sheetCompressionResistanceHigh = UILayoutPriority(800)
    }
    
    enum Content {
        case view(title: String, view: UIView)
        case controller(_: UIViewController)
    }
}
