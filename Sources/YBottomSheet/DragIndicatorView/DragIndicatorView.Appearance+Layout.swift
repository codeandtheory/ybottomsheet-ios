//
//  DragIndicatorView.Appearance+Layout.swift
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
        
        /// Default layout
        public static var `default` = Layout(cornerRadius: 2.0, size: CGSize(width: 60, height: 4))
        
        /// Initializes a `Layout`.
        /// - Parameters:
        ///   - cornerRadius: corner radius of drag indicator.
        ///   - size: size for the drag indicator.
        public init(
            cornerRadius: CGFloat,
            size: CGSize
        ) {
            self.cornerRadius = cornerRadius
            self.size = size
        }
    }
}
