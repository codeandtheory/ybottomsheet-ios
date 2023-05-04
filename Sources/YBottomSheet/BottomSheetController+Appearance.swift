//
//  BottomSheetController+Appearance.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

extension BottomSheetController {
    /// Determines the appearance of the bottom sheet.
    public struct Appearance {
        /// Appearance of the drag indicator. Default is `nil` (non-resizable sheet).
        public var indicatorAppearance: DragIndicatorView.Appearance?
        /// Appearance of the sheet header view. Default is `.default`.
        public var headerAppearance: SheetHeaderView.Appearance?
        /// Bottom sheet layout properties such as corner radius. Default is `.default`.
        public var layout: Layout
        /// Bottom sheet's shadow. Default is `nil` (no shadow).
        public var elevation: Elevation?
        /// Dimmer view color. Default is 'UIColor.black.withAlphaComponent(0.5)'.
        public var dimmerColor: UIColor?
        /// Animation for presenting the bottom sheet. Default = `.defaultPresent`.
        public var presentAnimation: Animation
        /// Animation for dismissing the bottom sheet. Default = `.defaultDismiss`.
        public var dismissAnimation: Animation
        ///
        /// The user can always dismiss the sheet from the close button if it is visible.
        public var isDismissAllowed: Bool
        
        /// Default appearance (fixed size sheet)
        public static let `default` = Appearance()
        /// Default appearance for a resizable sheet
        public static let defaultResizable = Appearance(indicatorAppearance: .default)

        /// Initializes an `Appearance`.
        /// - Parameters:
        ///   - indicatorAppearance: appearance of the drag indicator or pass `nil` to hide.
        ///   - headerAppearance: appearance of the sheet header view or pass `nil` to hide.
        ///   - layout: bottom sheet layout properties such as corner radius.
        ///   - elevation: bottom sheet's shadow or pass `nil` to hide.
        ///   - dimmerColor: dimmer view color or pass `nil` to hide.
        ///   - presentAnimation: animation for presenting the bottom sheet.
        ///   - dismissAnimation: animation for dismissing the bottom sheet.
        ///   - isDismissAllowed: whether the sheet can be dismissed by swiping down or tapping on the dimmer.
        public init(
            indicatorAppearance: DragIndicatorView.Appearance? = nil,
            headerAppearance: SheetHeaderView.Appearance? = .default,
            layout: Layout = .default,
            elevation: Elevation? = nil,
            dimmerColor: UIColor? = .black.withAlphaComponent(0.5),
            presentAnimation: Animation = .defaultPresent,
            dismissAnimation: Animation = .defaultDismiss,
            isDismissAllowed: Bool = true
        ) {
            self.indicatorAppearance = indicatorAppearance
            self.headerAppearance = headerAppearance
            self.layout = layout
            self.elevation = elevation
            self.dimmerColor = dimmerColor
            self.presentAnimation = presentAnimation
            self.dismissAnimation = dismissAnimation
            self.isDismissAllowed = isDismissAllowed
        }
    }
}
