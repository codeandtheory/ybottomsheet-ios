//
//  BottomSheetAnimatorTests.swift
//  YBottomSheet
//
//  Created by Dev Karan on 08/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YBottomSheet

final class BottomSheetAnimatorTests: XCTestCase {
    func test_init() {
        let sheetController = BottomSheetController(title: "Bottom Sheet", childView: UIView())
        let sut = makeSUT(sheetViewController: sheetController)

        XCTAssertEqual(sut.sheetViewController, sheetController)
    }

    func test_duration() {
        let main = UIViewController()
        let sheetController = BottomSheetController(title: "Bottom Sheet", childView: UIView())
        let sut = makeSUT(sheetViewController: sheetController)
        let context = MockAnimationContext(from: main, to: sheetController)

        XCTAssertEqual(sut.transitionDuration(using: context), sheetController.appearance.animationDuration)
    }

    func test_animate() {
        let main = UIViewController()
        let sheetController = BottomSheetController(title: "Bottom Sheet", childView: UIView())
        let sut = makeSUT(sheetViewController: sheetController)
        let context = MockAnimationContext(from: main, to: sheetController)

        XCTAssertFalse(context.wasCompleteCalled)
        sut.animateTransition(using: context)
        XCTAssertTrue(context.wasCompleteCalled)
        XCTAssertFalse(context.didComplete)
    }
}

private extension BottomSheetAnimatorTests {
    func makeSUT(
        sheetViewController: BottomSheetController,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> BottomSheetAnimator {
        let sut = BottomSheetAnimator(sheetViewController: sheetViewController)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}

class MockAnimationContext: NSObject {
    var wasCancelled = false
    var wasCompleteCalled = false
    var didComplete = false

    let fromViewController: UIViewController?
    let toViewController: UIViewController?
    let containerView: UIView

    init(from: UIViewController?, to: UIViewController?) {
        self.fromViewController = from
        self.toViewController = to
        containerView = UIView(frame: UIScreen.main.bounds)
        super.init()
    }
}

extension MockAnimationContext: UIViewControllerContextTransitioning {
    var isAnimated: Bool { true }

    var isInteractive: Bool { false }

    var transitionWasCancelled: Bool { wasCancelled }

    var presentationStyle: UIModalPresentationStyle { .custom }

    func updateInteractiveTransition(_ percentComplete: CGFloat) { }

    func finishInteractiveTransition() { }

    func cancelInteractiveTransition() { }

    func pauseInteractiveTransition() { }

    func completeTransition(_ didComplete: Bool) {
        wasCompleteCalled = true
        self.didComplete = didComplete
    }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case .from:
            return fromViewController
        case .to:
            return toViewController
        default:
            return nil
        }
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case .from:
            return fromViewController?.view
        case .to:
            return toViewController?.view
        default:
            return nil
        }
    }

    var targetTransform: CGAffineTransform { .identity }

    func initialFrame(for vc: UIViewController) -> CGRect {
        .zero
    }

    func finalFrame(for vc: UIViewController) -> CGRect {
        containerView.bounds
    }
}
