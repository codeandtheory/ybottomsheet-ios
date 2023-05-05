//
//  Animation+BottomSheetTests.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 5/4/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
@testable import YBottomSheet

final class AnimationBottomSheetTests: XCTestCase {
    func test_defaultPresent() {
        // Given
        let sut = Animation.defaultPresent

        // Then
        XCTAssertEqual(sut.duration, 0.3)
        XCTAssertEqual(sut.delay, 0.0)
        XCTAssertEqual(sut.curve, .regular(options: .curveEaseIn))
    }

    func test_defaultDismiss() {
        // Given
        let sut = Animation.defaultDismiss

        // Then
        XCTAssertEqual(sut.duration, 0.3)
        XCTAssertEqual(sut.delay, 0.0)
        XCTAssertEqual(sut.curve, .regular(options: .curveEaseOut))
    }
}
