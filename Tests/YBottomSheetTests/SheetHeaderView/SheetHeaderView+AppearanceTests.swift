//
//  SheetHeaderView+AppearanceTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 17/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YMatterType
@testable import YBottomSheet

final class SheetHeaderViewAppearanceTests: XCTestCase {
    func test_init_propertiesDefaultValue() {
        let sut = SheetHeaderView.Appearance.default
        let expected = SheetHeaderView.Appearance(
            title: (.label, .systemLabel.fontWeight(.semibold)),
            closeButtonImage: SheetHeaderView.Appearance.defaultCloseButtonImage,
            layout: .default
        )
        
        XCTAssertHeaderAppearanceEqual(sut, expected)
    }

    func test_defaultCloseButtonImage() {
        let sut = SheetHeaderView.Appearance.defaultCloseButtonImage
        XCTAssertEqual(sut, BottomSheetController.Images.xmark.image)
    }
}

extension XCTestCase {
    /// Compares two sheet header view appearances and asserts if they are not equal.
    /// - Parameters:
    ///   - lhs: the first appearance to compare
    ///   - rh2: the second appearance to compare
    func XCTAssertHeaderAppearanceEqual(_ lhs: SheetHeaderView.Appearance, _ rhs: SheetHeaderView.Appearance) {
        XCTAssertEqual(lhs.title.textColor, rhs.title.textColor)
        XCTAssertTypographyEqual(lhs.title.typography, rhs.title.typography)
        XCTAssertEqual(lhs.closeButtonImage, rhs.closeButtonImage)
        XCTAssertEqual(lhs.layout, rhs.layout)
    }
}
