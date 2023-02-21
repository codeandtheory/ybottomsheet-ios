//
//  SheetHeaderViewAppearanceTests.swift
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
        XCTAssertEqual(sut.title.textColor, .label)
        XCTAssertEqual(sut.title.typography.fontFamily.familyName, Typography.systemFamily.familyName)
        XCTAssertEqual(sut.title.typography.fontSize, UIFont.labelFontSize)
        XCTAssertEqual(sut.title.typography.fontWeight, .semibold)
        XCTAssertEqual(sut.closeButtonImage, UIImage(systemName: "xmark"))
        XCTAssertEqual(sut.layout, SheetHeaderView.Appearance.Layout.default)
    }
}
