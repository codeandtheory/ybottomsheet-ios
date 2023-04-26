//
//  SheetHeaderViewTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 17/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YMatterType
@testable import YBottomSheet

final class SheetHeaderViewTests: XCTestCase {
    var isDismissed = false
    
    func test_init_withDefaultValues() {
        let sut = makeSUT()

        XCTAssertEqual(sut.titleLabel.textColor, .label)
        XCTAssertTypographyEqual(sut.titleLabel.typography, .systemLabel.fontWeight(.semibold))
        XCTAssertEqual(sut.closeButton.isHidden, false)
        XCTAssertEqual(sut.titleLabel.text, "")
    }
    
    func test_init_withCustomValues() {
        let headerTitle = "Bottom Sheet"
        let appearance = SheetHeaderView.Appearance(
            title: (.red, .systemButton.bold),
            closeButtonImage: nil,
            layout: .default
        )
        let sut = makeSUT(appearance: appearance, headerTitle: headerTitle)

        XCTAssertEqual(sut.titleLabel.textColor, .red)
        XCTAssertTypographyEqual(sut.titleLabel.typography, .systemButton.bold)
        XCTAssertEqual(sut.titleLabel.typography.fontFamily.familyName, Typography.systemFamily.familyName)
        XCTAssertEqual(sut.titleLabel.typography.fontSize, UIFont.buttonFontSize)
        XCTAssertEqual(sut.titleLabel.typography.fontWeight, .bold)
        XCTAssertEqual(sut.closeButton.isHidden, true)
        XCTAssertEqual(sut.titleLabel.text, headerTitle)
    }
    
    func test_changeHeaderViewAppearance() {
        let sut = makeSUT()
        let color: UIColor = .red
        
        XCTAssertNotEqual(sut.titleLabel.textColor, color)
        XCTAssertTypographyEqual(sut.titleLabel.typography, .systemLabel.fontWeight(.semibold))

        sut.appearance = SheetHeaderView.Appearance(
            title: (color, .smallSystem.bold),
            closeButtonImage: nil,
            layout: .default
        )
        
        XCTAssertEqual(sut.titleLabel.textColor, color)
        XCTAssertTypographyEqual(sut.titleLabel.typography, .smallSystem.bold)
    }
    
    func test_closeButtonAction() {
        let sut = makeSUT()
        sut.delegate = self
        
        XCTAssertFalse(isDismissed)
        
        sut.simulateCloseButtonTap()
        
        XCTAssertTrue(isDismissed)
    }
}

private extension SheetHeaderViewTests {
    func makeSUT(
        appearance: SheetHeaderView.Appearance = .default,
        headerTitle: String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SheetHeaderView {
        let sut = SheetHeaderView(title: headerTitle, appearance: appearance)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

extension SheetHeaderViewTests: SheetHeaderViewDelegate {
    func didTapCloseButton() {
        isDismissed = true
    }
}
