//
//  SheetHeaderViewAppearanceLayoutTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 17/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class SheetHeaderViewAppearanceLayoutTests: XCTestCase {
    func test_propertiesDefaultValue() {
        let sut = SheetHeaderView.Appearance.Layout.default
        XCTAssertEqual(
            sut.contentInset,
            NSDirectionalEdgeInsets(topAndBottom: 0, leadingAndTrailing: 16)
        )
        XCTAssertEqual(sut.gap, 8)
    }
    
    func test_propertiesWithRandomValues() {
        let sut = SheetHeaderView.Appearance.Layout(
            contentInset: NSDirectionalEdgeInsets(topAndBottom: 0, leadingAndTrailing: 20),
            gap: 26
        )
        XCTAssertEqual(sut.contentInset, NSDirectionalEdgeInsets(topAndBottom: 0, leadingAndTrailing: 20))
        XCTAssertEqual(sut.gap, 26)
    }
}
