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
        /// Animation duration on bottom sheet. Default is `0.3`.
        public var animationDuration: TimeInterval
        /// Animation type during presenting. Default is `curveEaseIn`.
        public var presentAnimationCurve: UIView.AnimationOptions
        /// Animation type during dismissing. Default is `curveEaseOut`.
        public var dismissAnimationCurve: UIView.AnimationOptions
        /// Minimum top offset of sheet from safe area top. Default is `44`.
        ///
        /// The top of the sheet will not move beyond this gap from the top of the safe area.
        public var minimumTopOffset: CGFloat
        /// Whether the sheet can be dismissed by swiping down or tapping on the dimmer. Default is `true`.
        /// (Optional) Minimum content view height. Default is `nil`.
        ///
        /// Only applicable for resizable sheets. `nil` means to use the content view's intrinsic height as the minimum.
        public var minimumContentHeight: CGFloat?
        /// Whether the sheet can be dismissed by swiping down or tapping on the dimmer. Default is `true`.
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
        ///   - elevation: bottom sheet's shadow or pass `nil` to hide
        ///   - dimmerColor: dimmer view color or pass `nil` to hide.
        ///   - animationDuration: animation duration for bottom sheet. Default is `0.3`.
        ///   - presentAnimationCurve: animation type during presenting.
        ///   - dismissAnimationCurve: animation type during dismiss.
        ///   - minimumTopOffset: minimum top offset. Default is `44`
        ///   - minimumContentHeight: (optional) minimum content view height.
        ///   - isDismissAllowed: whether the sheet can be dismissed by swiping down or tapping on the dimmer.
        public init(
            indicatorAppearance: DragIndicatorView.Appearance? = nil,
            headerAppearance: SheetHeaderView.Appearance? = .default,
            layout: Layout = .default,
            elevation: Elevation? = nil,
            dimmerColor: UIColor? = .black.withAlphaComponent(0.5),
            animationDuration: TimeInterval = 0.3,
            presentAnimationCurve: UIView.AnimationOptions = .curveEaseIn,
            dismissAnimationCurve: UIView.AnimationOptions = .curveEaseOut,
            minimumTopOffset: CGFloat = 44,
            minimumContentHeight: CGFloat? = nil,
            isDismissAllowed: Bool = true
        ) {
            self.indicatorAppearance = indicatorAppearance
            self.headerAppearance = headerAppearance
            self.layout = layout
            self.elevation = elevation
            self.dimmerColor = dimmerColor
            self.animationDuration = animationDuration
            self.presentAnimationCurve = presentAnimationCurve
            self.dismissAnimationCurve = dismissAnimationCurve
            self.minimumTopOffset = minimumTopOffset
            self.minimumContentHeight = minimumContentHeight
            self.isDismissAllowed = isDismissAllowed
        }
    }
}
