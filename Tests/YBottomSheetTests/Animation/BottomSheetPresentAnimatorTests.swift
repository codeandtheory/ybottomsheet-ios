//
//  BottomSheetPresentAnimatorTests.swift
//  YBottomSheet
//
//  Created by Mark Pospesel on 21/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetPresentAnimatorTests: XCTestCase {
    func test_animate() throws {
        let sheetController = makeSheet()
        let (sut, context) = try makeSUT(sheetViewController: sheetController, to: sheetController)

        XCTAssertTrue(sut is BottomSheetPresentAnimator)
        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertTrue(context.didComplete)
    }

    func test_animateWithoutReduceMotion_TranslatesUp() throws {
        let sheetController = makeSheet()
        let (sut, context) = try makeSUT(
            sheetViewController: sheetController,
            to: sheetController,
            isReduceMotionEnabled: false
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(sheetController.dimmerView.alpha, 1)
        XCTAssertLessThan(sheetController.sheetView.frame.minY, context.containerView.bounds.maxY)
    }

    func test_animateWithReduceMotion_FadesIn() throws {
        let sheetController = makeSheet()
        let (sut, context) = try makeSUT(
            sheetViewController: sheetController,
            to: sheetController,
            isReduceMotionEnabled: true
        )

        sut.animateTransition(using: context)

        // Wait for the run loop to tick (animate keyboard)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.01))
        XCTAssertEqual(sheetController.dimmerView.alpha, 1)
        XCTAssertEqual(sheetController.sheetView.alpha, 1)
    }

    func test_animateWithoutTo_Fails() throws {
        let sheetController = makeSheet()
        let (sut, context) = try makeSUT(sheetViewController: sheetController, to: nil)

        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)

        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertFalse(context.didComplete)
    }
}

private extension BottomSheetPresentAnimatorTests {
    func makeSUT(
        sheetViewController: BottomSheetController,
        to: UIViewController?,
        isReduceMotionEnabled: Bool? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> (UIViewControllerAnimatedTransitioning, MockAnimationContext) {
        let main = UIViewController()
        let animator = try XCTUnwrap(
            sheetViewController.animationController(
                forPresented: sheetViewController,
                presenting: main,
                source: main
            ) as? BottomSheetAnimator
        )
        animator.reduceMotionOverride = isReduceMotionEnabled
        let context = MockAnimationContext(from: main, to: to)
        trackForMemoryLeaks(animator, file: file, line: line)
        trackForMemoryLeaks(context, file: file, line: line)
        return (animator, context)
    }

    func makeSheet(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> BottomSheetController {
        let sheet = BottomSheetController(
            title: "Bottom Sheet",
            childView: UIView(),
            appearance: BottomSheetController.Appearance(animationDuration: 0.0)
        )
        trackForMemoryLeaks(sheet)
        return sheet
    }
}
