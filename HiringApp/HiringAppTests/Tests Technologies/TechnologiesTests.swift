//
//  HiringAppTests.swift
//  HiringAppTests
//
//  Created by Alejandro Garcia on 14/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringApp

class TechnologiesTests: SnapshotTestCase {
    
    func testSnapshotTechnologies() {
        
        let technologiesVC = TechnologiesBuilder.build()
        guard let techsVC = technologiesVC else { fatalError() }
        verifyViewController(techsVC)
    }
    
}
