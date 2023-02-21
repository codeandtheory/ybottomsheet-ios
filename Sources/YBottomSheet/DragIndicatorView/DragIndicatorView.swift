//
//  DragIndicatorView.swift
//  YBottomSheet
//
//  Created by Dev Karan on 03/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI

/// Drag handle indicator for a bottom sheet.
open class DragIndicatorView: UIView {
    /// Appearance for the drag indicator (color and layout).
    public var appearance: DragIndicatorView.Appearance {
        didSet {
            updateViewAppearance()
            invalidateIntrinsicContentSize()
        }
    }
    
    /// :nodoc:
    public override var intrinsicContentSize: CGSize {
        appearance.layout.size
    }
    
    /// Initializes a drag indicator view.
    /// - Parameter appearance: appearance for the drag indicator
    public init(appearance: Appearance = .default) {
        self.appearance = appearance
        super.init(frame: .zero)
        
        build()
    }
    
    /// :nodoc:
    required public init?(coder: NSCoder) { nil }
}

private extension DragIndicatorView {
    func build() {
        buildConstraints()
        updateViewAppearance()
    }

    func buildConstraints() {
        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentHuggingPriority(.required, for: .vertical)
    }

    func updateViewAppearance() {
        self.backgroundColor = appearance.color
        self.layer.cornerRadius = appearance.layout.cornerRadius
    }
}
