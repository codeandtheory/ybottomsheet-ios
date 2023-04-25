//
//  BottomSheetController+StringsTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 15/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
@testable import YBottomSheet

final class BottomSheetControllerStringsTests: XCTestCase {
    func testLoad() {
        BottomSheetController.Strings.allCases.forEach {
            // Given a localized string constant
            let string = $0.localized
            // it should not be empty
            XCTAssertFalse(string.isEmpty)
            // and it should not equal its key
            XCTAssertNotEqual($0.rawValue, string)
        }
    }
}
