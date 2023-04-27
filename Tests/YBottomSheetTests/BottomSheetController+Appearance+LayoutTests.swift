//
//  BottomSheetController+Appearance+LayoutTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetControllerAppearanceLayoutTests: XCTestCase {
    func test_propertiesDefaultValue() {
        let sut = BottomSheetController.Appearance.Layout.default
        XCTAssertEqual(sut.cornerRadius, 16)
    }
    
    func test_propertiesWithRandomValues() {
        let radius = CGFloat(Int.random(in: 1...15))
        let sut = BottomSheetController.Appearance.Layout(
            cornerRadius: radius
        )
        XCTAssertEqual(sut.cornerRadius, radius)
    }
}
