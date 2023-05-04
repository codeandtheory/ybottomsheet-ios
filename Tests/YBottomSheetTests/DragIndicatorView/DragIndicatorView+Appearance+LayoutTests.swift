//
//  DragIndicatorView+Appearance+LayoutTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 03/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YBottomSheet

final class DragIndicatorViewAppearanceLayoutTests: XCTestCase {
    func test_propertiesDefaultValue() {
        let sut = DragIndicatorView.Appearance.Layout.default
        XCTAssertEqual(sut.cornerRadius, 2)
        XCTAssertEqual(sut.size, CGSize(width: 60, height: 4))
        XCTAssertEqual(sut.topInset, 8)
    }
    
    func test_propertiesWithCustomValues() {
        let sut = DragIndicatorView.Appearance.Layout(
            cornerRadius: 8,
            size: CGSize(width: 100, height: 16),
            topInset: 24
        )
        XCTAssertEqual(sut.cornerRadius, 8)
        XCTAssertEqual(sut.size, CGSize(width: 100, height: 16))
        XCTAssertEqual(sut.topInset, 24)
    }
}
