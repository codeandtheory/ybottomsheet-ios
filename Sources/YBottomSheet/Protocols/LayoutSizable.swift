//
//  LayoutSizable.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 5/1/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Represents any view or view controller that knows how to size itself
@objc
public protocol LayoutSizable {
    /// Ideal layout size
    @objc var layoutSize: CGSize { get }
}

extension UIView: LayoutSizable {
    /// By default calls `systemLayoutSizeFitting`
    @objc
    open var layoutSize: CGSize {
        systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

extension UIScrollView {
    /// By default returns `contentSize`
    @objc
    open override var layoutSize: CGSize {
        contentSize
    }
}

extension UITableView {
    /// By default returns `contentSize`
    @objc
    open override var layoutSize: CGSize {
        reloadData()
        return super.layoutSize
    }
}

extension UICollectionView {
    /// By default returns the layout's `collectionViewContentSize`
    @objc
    open override var layoutSize: CGSize {
        collectionViewLayout.collectionViewContentSize
    }
}

extension UIViewController: LayoutSizable {
    /// A view controller's layout size is that of its view
    @objc
    open var layoutSize: CGSize {
        view.layoutSize
    }
}

extension UINavigationController {
    /// For navigation controller the ideal layout size is that of its child controller combined
    /// with the navigation bar height
    @objc
    open override var layoutSize: CGSize {
        let barHeight = navigationBar.intrinsicContentSize.height
        var childSize: CGSize = .zero
        if let child = children.last {
            childSize = child.layoutSize
        }
        return CGSize(width: childSize.width, height: barHeight + childSize.height)
    }
}
