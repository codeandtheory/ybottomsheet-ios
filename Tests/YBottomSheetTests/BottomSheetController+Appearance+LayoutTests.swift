//
//  BottomSheetController+Appearance+LayoutTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetAppearanceLayoutTests: XCTestCase {
    func test_propertiesDefaultValue() {
        let sut = BottomSheetController.Appearance.Layout.default
        XCTAssertEqual(sut.cornerRadius, 16)
        XCTAssertEqual(sut.minimumTopOffset, 44)
        XCTAssertNil(sut.maximumContentHeight)
        XCTAssertNil(sut.idealContentHeight)
        XCTAssertEqual(sut.minimumContentHeight, 88)
    }
    
    func test_propertiesWithRandomValues() {
        let radius = CGFloat(Int.random(in: 1...15))
        let idealHeight = CGFloat(Int.random(in: 128...512))
        let sut = BottomSheetController.Appearance.Layout(
            cornerRadius: radius,
            idealContentHeight: idealHeight
        )
        XCTAssertEqual(sut.cornerRadius, radius)
        XCTAssertEqual(sut.idealContentHeight, idealHeight)
    }
}
