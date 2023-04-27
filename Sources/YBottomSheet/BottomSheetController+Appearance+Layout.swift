//
//  BottomSheetController+Appearance+Layout.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

extension BottomSheetController.Appearance {
    /// A collection of layout properties for the `BottomSheetController`.
    public struct Layout: Equatable {
        /// Corner radius of bottom sheet view. Default is `16`.
        public var cornerRadius: CGFloat

        /// Minimum top offset of sheet from safe area top. Default is `44`.
        ///
        /// The top of the sheet will not move beyond this gap from the top of the safe area.
        public var minimumTopOffset: CGFloat

        /// Maximum content height of sheet.
        ///
        /// Only applicable for resizable sheets.
        /// If `nil` a resizable sheet will be allowed to grow until it nearly fills the screen.
        /// c.f. `minimumTopOffset`
        public var maximumContentHeight: CGFloat?

        /// Ideal content height of sheet.
        ///
        /// Used to determine the initial size of the sheet.
        /// If `nil`, the content's `instrinsicContentHeight` will be used.
        public var idealContentHeight: CGFloat?

        /// Minimum content height of sheet.
        ///
        /// Only applicable for resizable sheets.
        /// A resizable sheet will not be allowed to shrink its content below this value.
        public var minimumContentHeight: CGFloat

        /// Default layout.
        public static let `default` = Layout(cornerRadius: 16)

        /// Initializes a sheet layout.
        /// - Parameters:
        ///   - cornerRadius: corner radius of bottom sheet view.

        // Initializes a bottom sheet layout.
        /// - Parameters:
        ///   - cornerRadius: corner radius of bottom sheet view.
        ///   - minimumTopOffset: minimum top offset. Default is `44`.
        ///   - maximumContentHeight: maximum content height of sheet. Default is `nil`.
        ///   - idealContentHeight: ideal content height of sheet. Default is `nil`.
        ///   - minimumContentHeight: minimum content height of sheet. Default is `88`.
        public init(
            cornerRadius: CGFloat,
            minimumTopOffset: CGFloat = 44,
            maximumContentHeight: CGFloat? = nil,
            idealContentHeight: CGFloat? = nil,
            minimumContentHeight: CGFloat = 88
        ) {
            self.cornerRadius = cornerRadius
            self.minimumTopOffset = minimumTopOffset
            self.maximumContentHeight = maximumContentHeight
            self.idealContentHeight = idealContentHeight
            self.minimumContentHeight = minimumContentHeight
        }
    }
}
