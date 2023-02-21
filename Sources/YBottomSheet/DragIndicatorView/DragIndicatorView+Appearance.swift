//
//  DragIndicatorView+Appearance.swift
//  YBottomSheet
//
//  Created by Dev Karan on 05/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension DragIndicatorView {
    /// Determines the appearance of the drag indicator handle of a bottom sheet.
    public struct Appearance {
        /// Drag indicator view color. Default is `tertiaryLabel`.
        public var color: UIColor
        /// Drag indicator view layout properties such as size, corner radius. Default is `.default`.
        public var layout: Layout
        
        /// Default appearance
        public static var `default` = Appearance()
        
        /// Initializes an `Appearance`.
        /// - Parameters:
        ///   - color: drag indicator background color.
        ///   - layout: `drag indicator layout properties such as drag indicator size, corner radius.
        public init(
            color: UIColor = .tertiaryLabel,
            layout: Layout =  .default
        ) {
            self.color = color
            self.layout = layout
        }
    }
}
