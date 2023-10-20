//
//  BottomSheetController.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// A view controller that manages a bottom sheet.
public class BottomSheetController: UIViewController {
    internal let content: Content
    private var shadowSize: CGSize = .zero

    internal var minimumTopOffsetAnchor: NSLayoutConstraint?
    private var topAnchor: NSLayoutConstraint?
    internal var indicatorTopAnchor: NSLayoutConstraint?
    private var maximumContentHeightAnchor: NSLayoutConstraint?
    internal var idealContentHeightAnchor: NSLayoutConstraint?
    internal var minimumContentHeightAnchor: NSLayoutConstraint?

    private var panGesture: UIPanGestureRecognizer?
    internal lazy var lastYOffset: CGFloat = { sheetView.frame.origin.y }()

    /// Minimum downward velocity beyond which we interpret a pan gesture as a downward swipe.
    public var dismissThresholdVelocity: CGFloat = 1000
    
    /// Dimmer tap view
    let dimmerTapView: UIView = {
        let view = UIView()
        view.accessibilityTraits = .button
        view.accessibilityLabel = BottomSheetController.Strings.closeButton.localized
        view.accessibilityIdentifier = AccessibilityIdentifiers.dimmerId
        return view
    }()
    /// Dimmer view.
    let dimmerView = UIView()
    /// Bottom sheet view.
    let sheetView = UIView()
    /// Bottom sheet container view.
    let sheetContainerView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()
    /// Bottom sheet drag indicator view.
    public internal(set) var indicatorView: DragIndicatorView!
    /// Container view for the drag indicator.
    internal let indicatorContainer = UIView()
    /// Bottom sheet header view.
    public internal(set) var headerView: SheetHeaderView!
    /// Holds the sheet's child content (view or view controller).
    let contentView = UIView()

    /// Comprises the indicator view, the header view, and the content view.
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    /// Appearance for bottom sheet.
    public var appearance: BottomSheetController.Appearance {
        didSet {
            guard isViewLoaded else { return }
            updateViewAppearance()
        }
    }

    /// Whether the sheet is resizable or not.
    public var isResizable: Bool { appearance.indicatorAppearance != nil }

    /// Whether the sheet contains a header.
    ///
    /// This may either be because no header appearance was specified or because the child controller is a
    /// `UINavigationController` and hence already has its own `UINavigationBar` header.
    public var hasHeader: Bool {
        guard appearance.headerAppearance != nil else { return false }

        if case let .controller(childController) = content {
            return !(childController is UINavigationController)
        }

        return true
    }

    /// Initializes a bottom sheet.
    /// - Parameters:
    ///   - title: bottom sheet title.
    ///   - childView: content view.
    ///   - appearance: bottom sheet appearance. Default is `.default`.
    public required init(
        title: String,
        childView: UIView,
        appearance: BottomSheetController.Appearance = .default
    ) {
        self.content = .view(title: title, view: childView)
        self.appearance = appearance
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    /// Initializes a bottom sheet.
    /// - Parameters:
    ///   - childController: content view controller.
    ///   - appearance: bottom sheet appearance. Default is `.default`.
    public required init(
        childController: UIViewController,
        appearance: BottomSheetController.Appearance = .default
    ) {
        self.content = .controller(childController)
        self.appearance = appearance
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    /// :nodoc:
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not available for BottomSheetController")
    }

    /// :nodoc:
    public override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    /// :nodoc:
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // set initial VO focus to the sheet not the dimmer
        UIAccessibility.post(notification: .screenChanged, argument: sheetView)
    }

    /// :nodoc:
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard shadowSize != sheetView.bounds.size else { return }
        updateShadow()
        shadowSize = sheetView.bounds.size
    }
    
    /// Performing the accessibility escape gesture dismisses the bottom sheet.
    public override func accessibilityPerformEscape() -> Bool {
        didDismiss()
        return true
    }
    
    /// Dismisses the bottom sheet if allowed.
    ///
    /// This method is not called when the header's close button is tapped.
    func didDismiss() {
        if appearance.isDismissAllowed {
            onDismiss()
        }
    }
    
    /// update views
    public func updateViews() {
       updateViewAppearance()
    }
}

internal extension BottomSheetController {
    func updateViewAppearance() {
        dimmerTapView.isAccessibilityElement = appearance.isDismissAllowed
        sheetContainerView.layer.cornerRadius = appearance.layout.cornerRadius
        minimumTopOffsetAnchor?.constant = appearance.layout.minimumTopOffset
        updateShadow()
        dimmerView.backgroundColor = appearance.dimmerColor
        updateIndicatorView()
        updateHeaderView()
        updateChildView()
    }

    func addGestures() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeDown))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onDimmerTap))
        dimmerTapView.addGestureRecognizer(tapGesture)
    }

    var childContentSize: CGSize {
        switch content {
        case .view(_, let view):
            return view.layoutSize
        case .controller(let viewController):
            return viewController.layoutSize
        }
    }

    func updateShadow() {
        appearance.elevation?.apply(layer: sheetView.layer, cornerRadius: appearance.layout.cornerRadius)
    }
}

private extension BottomSheetController {
    func commonInit() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    func updateIndicatorView() {
        indicatorContainer.isHidden = !isResizable
        if let indicatorAppearance = appearance.indicatorAppearance {
            indicatorView.appearance = indicatorAppearance
            indicatorTopAnchor?.constant = indicatorAppearance.layout.topInset
            if panGesture == nil {
                let pan = UIPanGestureRecognizer()
                pan.addTarget(self, action: #selector(handlePan))
                sheetView.addGestureRecognizer(pan)
                panGesture = pan
            }
        } else {
            if let pan = panGesture {
                sheetView.removeGestureRecognizer(pan)
                panGesture = nil
            }
        }
    }

    func updateHeaderView() {
        headerView.isHidden = !hasHeader
        if let headerAppearance = appearance.headerAppearance {
            headerView.appearance = headerAppearance
        }
    }

    func updateChildView() {
        guard let childView = contentView.subviews.first else { return }

        // Enforce maximum height (if any)
        if let maximum = appearance.layout.maximumContentHeight {
            if let maximumContentHeightAnchor = maximumContentHeightAnchor {
                maximumContentHeightAnchor.constant = maximum
            } else {
                maximumContentHeightAnchor = childView.constrain(
                    .heightAnchor,
                    relatedBy: .lessThanOrEqual,
                    constant: maximum
                )
            }
        } else {
            maximumContentHeightAnchor?.isActive = false
        }

        // Enforce ideal height (if any)
        // (otherwise sheet height defaults to childView.instrinsicContentSize.height)
        let idealHeight = appearance.layout.idealContentHeight ?? childContentSize.height
        if idealHeight > 0.0 {
            if let idealContentHeightAnchor = idealContentHeightAnchor {
                idealContentHeightAnchor.constant = idealHeight
            } else {
                idealContentHeightAnchor = childView.constrain(
                    .heightAnchor,
                    constant: idealHeight,
                    priority: Priorities.idealContentSize
                )
            }
        } else {
            idealContentHeightAnchor?.isActive = false
        }

        // Enforce minimum height
        minimumContentHeightAnchor?.constant = appearance.layout.minimumContentHeight

        childView.setContentCompressionResistancePriority(Priorities.sheetCompressionResistance, for: .vertical)
    }
    
    func onDismiss() {
        dismiss(animated: true)
    }
}

extension BottomSheetController: SheetHeaderViewDelegate {
    @objc
    func didTapCloseButton() {
        // Directly dismiss the sheet without considering `isDismissAllowed`.
        onDismiss()
    }
}

private extension BottomSheetController {
    @objc
    func onSwipeDown(sender: UIGestureRecognizer) {
        didDismiss()
    }
    
    @objc
    func onDimmerTap(sender: UIGestureRecognizer) {
        didDismiss()
    }

    @objc
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            let translation = gesture.translation(in: sheetView)
            let offset = lastYOffset + translation.y - view.safeAreaInsets.top
            if let topAnchor = topAnchor {
                topAnchor.constant = offset
            } else {
                topAnchor = sheetView.constrain(
                    .topAnchor,
                    to: view.safeAreaLayoutGuide.topAnchor,
                    constant: offset,
                    priority: Priorities.panGesture
                )
            }
            view.layoutIfNeeded()
        case .ended:
            lastYOffset = sheetView.frame.origin.y
            let velocity = gesture.velocity(in: sheetView)
            if velocity.y > dismissThresholdVelocity {
                didDismiss()
            }
        default: break
        }
    }
}

// Methods for unit testing
internal extension BottomSheetController {
    @objc
    func simulateOnSwipeDown() {
        onSwipeDown(sender: UISwipeGestureRecognizer())
    }

    @objc
    func simulateOnDimmerTap() {
        onDimmerTap(sender: UITapGestureRecognizer())
    }

    @objc @discardableResult
    func simulateDragging(_ gesture: UIPanGestureRecognizer) -> Bool {
        guard isResizable else { return false }
        handlePan(gesture)
        return true
    }

    @objc
    func simulateTapCloseButton() {
        didTapCloseButton()
    }
}
