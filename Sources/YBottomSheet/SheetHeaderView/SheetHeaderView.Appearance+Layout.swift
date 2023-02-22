//
//  SheetHeaderView.Appearance+Layout.swift
//  YBottomSheet
//
//  Created by Dev Karan on 17/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension SheetHeaderView.Appearance {
    /// A collection of layout properties for the `SheetHeaderView`.
    public struct Layout: Equatable {
        /// The custom distance the content inset from the `HeaderView`.
        /// Default is `{0, 16, 0, 16}`.
        public let contentInset: NSDirectionalEdgeInsets
        /// The minimum required horizontal spacing between title label and message label. Default is `8.0`.
        public let gap: CGFloat
        
        /// Default sheet header layout.
        public static let `default` = Layout(
            contentInset: NSDirectionalEdgeInsets(topAndBottom: 0, leadingAndTrailing: 16),
            gap: 8
        )
        
        /// Initializes a layout.
        /// - Parameters:
        ///   - contentInset: distance the content is inset from the header bounds.
        ///   - gap: horizontal spacing between icon and label.
        public init(
            contentInset: NSDirectionalEdgeInsets,
            gap: CGFloat
        ) {
            self.contentInset = contentInset
            self.gap = gap
        }
    }
}
