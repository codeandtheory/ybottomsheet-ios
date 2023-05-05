//
//  Animation+BottomSheet.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 5/4/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import YCoreUI

/// Default animations for bottom sheets
public extension Animation {
    /// Default animation for presenting a bottom sheet
    static let defaultPresent = Animation(curve: .regular(options: .curveEaseIn))

    /// Default animation for dismissing a bottom sheet
    static let defaultDismiss = Animation(curve: .regular(options: .curveEaseOut))
}
