//
//  LayoutSizableTests.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 5/3/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
@testable import YBottomSheet

final class LayoutSizableTests: XCTestCase {
    func test_viewLayoutSize_deliversZeroSize() {
        let sut = UIView()

        XCTAssertEqual(sut.layoutSize, .zero)
    }

    func test_labelLayoutSize_deliversNonZeroSize() {
        let sut = UILabel()
        sut.text = "Hello"

        XCTAssertNotEqual(sut.layoutSize, .zero)
    }

    func test_scrollViewLayoutSize_deliversContentSize() {
        let sut = UIScrollView()
        let label = UILabel()
        let insets = NSDirectionalEdgeInsets(all: CGFloat(Int.random(in: 1...32)))
        label.text = "Hello\nWorld"
        sut.addSubview(label)
        label.constrainEdges(with: insets)
        sut.layoutIfNeeded()

        XCTAssertNotEqual(sut.layoutSize, .zero)
        XCTAssertNotEqual(sut.layoutSize, label.layoutSize)
        XCTAssertEqual(
            sut.layoutSize.height.ceiled(),
            (label.layoutSize.height + insets.vertical).ceiled()
        )
    }

    func test_tableViewLayoutSize_deliversContentSize() {
        let sut = UITableView()
        let dataSource = GroceryList()
        sut.rowHeight = 44
        sut.dataSource = dataSource

        XCTAssertEqual(
            sut.layoutSize.height,
            (44 * CGFloat(dataSource.items.count))
        )
    }

    func test_collectionViewLayoutSize_deliversContentSize() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let sut = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        let dataSource = GroceryList()
        sut.dataSource = dataSource

        XCTAssertNotEqual(sut.layoutSize, .zero)
    }

    func test_navigationControllerLayoutSize_deliversBarHeightPlusChildLayoutSize() {
        let vc = UIViewController()
        let child = ChildView()
        vc.view.addSubview(child)
        child.constrainEdges()
        vc.view.layoutIfNeeded()

        let sut = UINavigationController(rootViewController: vc)

        XCTAssertEqual(vc.layoutSize, CGSize(width: 300, height: 300))
        XCTAssertEqual(sut.layoutSize.height, sut.navigationBar.bounds.height + vc.layoutSize.height)
    }
}

class GroceryList: NSObject {
    var items = [
        "Milk",
        "Orange Juice",
        "Bananas",
        "Zebras"
    ]
}

extension GroceryList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension GroceryList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        let label = UILabel()
        label.text = items[indexPath.row]
        cell.contentView.addSubview(label)
        label.constrainEdges()
        return cell
    }
}
