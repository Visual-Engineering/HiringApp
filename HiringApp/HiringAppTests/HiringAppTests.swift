//
//  HiringAppTests.swift
//  HiringAppTests
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringApp

class HiringAppTests: SnapshotTestCase {
    
    func testSnapshotTechnologies() {
        let technologiesVC = TechnologiesBuilder.build()
        verifyViewController(technologiesVC)
    }
    
}