//
//  BottomSheetDismissAnimatorTests.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 21/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetDismissAnimatorTests: XCTestCase {
    func test_animate() throws {
        let sheetController = BottomSheetController(
            title: "Bottom Sheet",
            childView: UIView(),
            appearance: BottomSheetController.Appearance(animationDuration: 0.0)
        )
        let (sut, context) = try makeSUT(sheetViewController: sheetController, to: sheetController)

        XCTAssertTrue(sut is BottomSheetDismissAnimator)
        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertTrue(context.didComplete)
        XCTAssertEqual(sheetController.dimmerView.alpha, 0)
        XCTAssertEqual(sheetController.sheetView.frame.minY, context.containerView.bounds.maxY)
    }

    func test_animateWithoutTo_Fails() throws {
        let sheetController = BottomSheetController(
            title: "Bottom Sheet",
            childView: UIView()
        )
        let (sut, context) = try makeSUT(sheetViewController: sheetController, to: nil)

        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertFalse(context.didComplete)
    }
}

private extension BottomSheetDismissAnimatorTests {
    func makeSUT(
        sheetViewController: BottomSheetController,
        to: UIViewController?,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> (UIViewControllerAnimatedTransitioning, MockAnimationContext) {
        let main = UIViewController()
        let animator = try XCTUnwrap(sheetViewController.animationController(forDismissed: sheetViewController))
        let context = MockAnimationContext(from: main, to: to)
        trackForMemoryLeaks(animator, file: file, line: line)
        trackForMemoryLeaks(context, file: file, line: line)
        return (animator, context)
    }
}
