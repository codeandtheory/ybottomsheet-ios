//
//  BottomSheetController+AppearanceTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
import YMatterType
@testable import YBottomSheet

final class BottomSheetControllerAppearanceTests: XCTestCase {
    func test_init_propertiesDefaultValue() throws {
        let sut = BottomSheetController.Appearance.default
        XCTAssertNil(sut.indicatorAppearance)
        let headerAppearance = try XCTUnwrap(sut.headerAppearance)
        XCTAssertHeaderAppearanceEqual(headerAppearance, .default)
        XCTAssertEqual(sut.layout, .default)
        XCTAssertEqual(sut.elevation, nil)
        XCTAssertEqual(sut.dimmerColor, .black.withAlphaComponent(0.5))
        XCTAssertEqual(sut.presentAnimation, Animation(curve: .regular(options: .curveEaseIn)))
        XCTAssertEqual(sut.dismissAnimation, Animation(curve: .regular(options: .curveEaseOut)))
        XCTAssertTrue(sut.isDismissAllowed)
    }
}
