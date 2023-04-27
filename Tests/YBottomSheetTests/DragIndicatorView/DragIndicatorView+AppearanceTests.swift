//
//  DragIndicatorView+AppearanceTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 03/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class DragIndicatorViewAppearanceTests: XCTestCase {
    func test_init_propertiesDefaultValue() {
        let sut = DragIndicatorView.Appearance.default
        XCTAssertEqual(sut.layout, DragIndicatorView.Appearance.Layout.default)
        XCTAssertEqual(sut.color, .tertiaryLabel)
    }
}
