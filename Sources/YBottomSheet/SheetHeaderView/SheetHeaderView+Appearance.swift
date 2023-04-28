//
//  SheetHeaderView+Appearance.swift
//  YBottomSheet
//
//  Created by Dev Karan on 12/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YMatterType

extension SheetHeaderView {
    /// Determines the appearance of the sheet header view of a bottom sheet.
    public struct Appearance {
        /// A tuple consisting of `textColor` and `typography` for the title label.
        /// Default is `(.label, .systemLabel.fontWeight(.semibold))`.
        public let title: (textColor: UIColor, typography: Typography)
        /// Close button image. Default is SF symbol `xmark`.
        public let closeButtonImage: UIImage?
        /// Header view layout properties such as spacing between views. Default is `.default`.
        public let layout: Layout
        
        /// Default appearance
        public static let `default` = Appearance()

        /// Default close button image (SF symbol `xmark`)
        public static let defaultCloseButtonImage: UIImage = BottomSheetController.Images.xmark.image

        /// Initializes a sheet header appearance.
        /// - Parameters:
        ///   - title: tuple consisting of `textColor` and `typography` for the title label.
        ///   - closeButtonImage: close button image or pass `nil` to hide the button.
        ///   - layout: sheet header view layout properties such as spacing between views.
        public init(
            title: (textColor: UIColor, typography: Typography) = (.label, .systemLabel.fontWeight(.semibold)),
            closeButtonImage: UIImage? = defaultCloseButtonImage,
            layout: Layout = .default
        ) {
            self.title = title
            self.closeButtonImage = closeButtonImage
            self.layout = layout
        }
    }
}
