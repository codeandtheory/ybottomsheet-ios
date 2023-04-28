//
//  SheetHeaderView.swift
//  YBottomSheet
//
//  Created by Dev Karan on 12/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YCoreUI
import YMatterType

/// Header view for a bottom sheet to show optional title and optional close button.
///
/// (If neither title nor close button are visible, the header will not be shown.)
open class SheetHeaderView: UIView {
    /// Appearance for the sheet header (title text and close button).
    public var appearance: SheetHeaderView.Appearance {
        didSet {
            updateViewAppearance()
            updateViewContent()
        }
    }
    
    /// A label to display header title.
    public let titleLabel = TypographyLabel(typography: .systemLabel.fontWeight(.semibold))
    
    /// Close button to dismiss the bottom sheet.
    public let closeButton: UIButton = {
        let button = UIButton()
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.constrainAspectRatio(1)
        return button
    }()

    private let buttonSize = CGSize(width: 44, height: 44)
    private weak var closeButtonLeadingConstraint: NSLayoutConstraint?
    private weak var closeButtonTrailingConstraint: NSLayoutConstraint?
    weak var delegate: SheetHeaderViewDelegate?
    
    /// Initializes a sheet header view.
    /// - Parameters:
    ///   - title: title text.
    ///   - appearance: appearance for the sheet header.
    public init(title: String, appearance: Appearance = .default) {
        self.titleLabel.text = title
        self.appearance = appearance
        super.init(frame: .zero)
        
        build()
        updateViewAppearance()
        updateViewContent()
    }
    
    /// :nodoc:
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not available for SheetHeaderView")
    }

    @objc private func closeButtonAction() {
        delegate?.didTapCloseButton()
    }
    
    // For unit testing
    internal func simulateCloseButtonTap() {
        closeButtonAction()
    }
}

private extension SheetHeaderView {
    func build() {
        buildViews()
        buildConstraints()
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        closeButton.accessibilityLabel = BottomSheetController.Strings.closeButton.localized
        closeButton.accessibilityIdentifier = BottomSheetController.AccessibilityIdentifiers.buttonId
    }
    
    func buildViews() {
        addSubview(titleLabel)
        addSubview(closeButton)
    }
    
    func buildConstraints() {
        titleLabel.constrainCenter(.x, priority: UILayoutPriority(500))
        titleLabel.constrainCenter(.y)
        titleLabel.constrainEdges(.notTrailing, relatedBy: .greaterThanOrEqual, with: appearance.layout.contentInset)
        
        closeButton.constrainCenter(.y, to: titleLabel)
        closeButton.constrainSize(buttonSize)
        closeButton.constrainEdges(.vertical, relatedBy: .greaterThanOrEqual, with: appearance.layout.contentInset)
        closeButton.constrainEdges(.vertical, with: appearance.layout.contentInset, priority: UILayoutPriority(751))

        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentHuggingPriority(.required, for: .vertical)
    }
    
    func updateViewContent() {
        closeButton.setImage(appearance.closeButtonImage, for: .normal)
        closeButton.tintColor = appearance.title.textColor
        updateCloseButtonConstraints()
    }
    
    func updateViewAppearance() {
        titleLabel.textColor = appearance.title.textColor
        titleLabel.typography = appearance.title.typography
        closeButton.isHidden = (appearance.closeButtonImage == nil)
        // Restrict the title text from scaling past 44 pts in height
        titleLabel.maximumScaleFactor = buttonSize.height / appearance.title.typography.lineHeight
    }
    
    func updateCloseButtonConstraints() {
        // We want our button to be at least {44, 44} so that it meets HIG
        // recommendations for minimum tap target size, but the image might be much
        // smaller. Our default image is {17.5, 15.5}, so we want to adjust our constraints
        // so that the edges of the image, not the edges of the button are used.
        
        guard let imageWidth = appearance.closeButtonImage?.size.width else { return }
        let offset = max(0, (buttonSize.width - imageWidth) / 2)
        
        // deactivate old constraints (if any)
        closeButtonLeadingConstraint?.isActive = false
        closeButtonTrailingConstraint?.isActive = false
        
        // create new constraints
        
        // title text should not overlaps the button image
        closeButtonLeadingConstraint = closeButton.constrain(
            after: titleLabel,
            relatedBy: .greaterThanOrEqual,
            offset: appearance.layout.gap - offset
        )
        
        // button image should be inset the proper amount from the trailing edge
        closeButtonTrailingConstraint = closeButton.constrain(
            .trailingAnchor,
            to: trailingAnchor,
            constant: offset - appearance.layout.contentInset.trailing
        )
    }
}
