//
//  BottomSheetController+Images.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 4/26/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

extension BottomSheetController {
    /// Images
    enum Images: String, SystemImage, CaseIterable {
        /// xmark
        case xmark
        
        static var renderingMode: UIImage.RenderingMode { .alwaysTemplate }
    }
}
