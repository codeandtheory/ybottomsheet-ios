//
//  DragIndicatorView+Appearance+Layout.swift
//  YBottomSheet
//
//  Created by Dev Karan on 05/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension DragIndicatorView.Appearance {
    /// A collection of layout properties for the `DragIndicatorView`.
    public struct Layout: Equatable {
        /// Corner radius of drag indicator. Default is `2.0`.
        public var cornerRadius: CGFloat
        /// Size for the drag indicator. Default is {60, 4}.
        public var size: CGSize
        /// Inset of indicator from top of sheet. Default is `8.0`
        public var topInset: CGFloat
        /// Default layout.
        public static var `default` = Layout()
        
        /// Initializes a `Layout`.
        /// - Parameters:
        ///   - cornerRadius: corner radius of drag indicator.
        ///   - size: size for the drag indicator.
        ///   - topInset: inset of indicator from top of sheet.
        public init(
            cornerRadius: CGFloat = 2,
            size: CGSize = CGSize(width: 60, height: 4),
            topInset: CGFloat = 8
        ) {
            self.cornerRadius = cornerRadius
            self.size = size
            self.topInset = topInset
        }
    }
}
