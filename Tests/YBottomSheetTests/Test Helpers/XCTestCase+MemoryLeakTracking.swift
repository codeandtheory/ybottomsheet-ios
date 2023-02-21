//
//  XCTestCase+MemoryLeakTracking.swift
//  YBottomSheet
//
//  Created by Dev Karan on 10/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
