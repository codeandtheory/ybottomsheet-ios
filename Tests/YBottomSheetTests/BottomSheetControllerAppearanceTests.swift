//
//  BottomSheetControllerAppearanceTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YMatterType
@testable import YBottomSheet

final class BottomSheetControllerAppearanceTests: XCTestCase {
    func test_init_propertiesDefaultValue() {
        let sut = BottomSheetController.Appearance.default
        XCTAssertEqual(sut.layout, .default)
        XCTAssertEqual(sut.elevation, nil)
        XCTAssertEqual(sut.dimmerColor, .black.withAlphaComponent(0.5))
    }
}
