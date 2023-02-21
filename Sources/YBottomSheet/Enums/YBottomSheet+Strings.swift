//
//  YBottomSheet+Strings.swift
//  YBottomSheet
//
//  Created by Dev Karan on 15/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YCoreUI

extension BottomSheetController {
    enum Strings: String, Localizable, CaseIterable {
        case closeButton = "Close_Button"
        
        static var bundle: Bundle { .module }
    }
}
