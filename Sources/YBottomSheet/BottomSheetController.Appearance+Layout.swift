//
//  BottomSheetController.Appearance+Layout.swift
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
        
        /// Default layout.
        public static let `default` = Layout(cornerRadius: 16)
        
        /// Initializes a sheet layout.
        /// - Parameters:
        ///   - cornerRadius: corner radius of bottom sheet view.
        public init(cornerRadius: CGFloat) {
            self.cornerRadius = cornerRadius
        }
    }
}
