//
//  BottomSheetController+build.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 4/26/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

internal extension BottomSheetController {
    func build() {
        switch content {
        case .view(title: let title, view: let childView):
            build(childView, title: title)
        case .controller(let childController):
            build(childController)
        }
    }
}

private extension BottomSheetController {
    func build(_ subview: UIView, title: String) {
        contentView.addSubview(subview)
        subview.constrainEdges()

        if let backgroundColor = subview.backgroundColor,
           backgroundColor.rgbaComponents.alpha == 1 {
            // use the subview's background color for the sheet
            sheetContainerView.backgroundColor = backgroundColor
            // but we have to set the subview's background to nil or else
            // it will overflow the sheet and not be cropped by the corner radius.
            subview.backgroundColor = nil
        }

        indicatorView = DragIndicatorView(appearance: appearance.indicatorAppearance ?? .default)
        indicatorContainer.addSubview(indicatorView)

        headerView = SheetHeaderView(title: title, appearance: appearance.headerAppearance ?? .default)
        headerView.delegate = self
        buildSheet()
    }

    func build(_ childController: UIViewController) {
        addChild(childController)
        build(childController.view, title: childController.title ?? "")
        childController.didMove(toParent: self)
    }

    func buildSheet() {
        buildViews()
        buildConstraints()
        updateViewAppearance()
        addGestures()
    }

    func buildViews() {
        view.addSubview(dimmerView)
        view.addSubview(dimmerTapView)
        view.addSubview(sheetView)
        sheetView.addSubview(sheetContainerView)
        sheetContainerView.addSubview(stackView)
        stackView.addArrangedSubview(indicatorContainer)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(contentView)
    }

    func buildConstraints() {
        dimmerView.constrainEdges()
        dimmerTapView.constrainEdges(.notBottom)
        dimmerTapView.constrain(.bottomAnchor, to: sheetView.topAnchor)
        sheetContainerView.constrainEdges()

        sheetView.constrainEdges(.notTop)
        minimumTopOffsetAnchor = sheetView.constrain(
            .topAnchor,
            to: view.safeAreaLayoutGuide.topAnchor,
            relatedBy: .greaterThanOrEqual
        )
        minimumContentHeightAnchor = contentView.constrain(
            .heightAnchor,
            relatedBy: .greaterThanOrEqual,
            constant: appearance.layout.minimumContentHeight
        )

        indicatorView.constrain(.bottomAnchor, to: indicatorContainer.bottomAnchor)
        indicatorTopAnchor = indicatorView.constrain(
            .topAnchor,
            to: indicatorContainer.topAnchor
        )
        indicatorView.constrainCenter(.x)

        stackView.constrainEdges(.top)
        stackView.constrainEdges(.horizontal, to: view.safeAreaLayoutGuide)
        stackView.constrainEdges(.bottom, to: view.safeAreaLayoutGuide)
        contentView.constrainEdges(.horizontal)
        headerView.constrainEdges(.horizontal)
    }
}
