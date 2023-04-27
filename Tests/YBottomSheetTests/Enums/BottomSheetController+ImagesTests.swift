//
//  BottomSheetController+ImagesTests.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 4/26/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetControllerImagesTests: XCTestCase {
    func test_loadImages() {
        BottomSheetController.Images.allCases.forEach {
            XCTAssertNotNil($0.loadImage())
        }
    }
}
