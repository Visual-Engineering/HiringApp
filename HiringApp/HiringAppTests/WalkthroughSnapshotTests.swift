//
//  WalkthroughSnapshotTests.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 05/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import XCTest
@testable import HiringApp

class WalkthroughSnapshotTests: SnapshotTestCase {
    
    func testSnapshotWalkthroughPageOne() {
        let pageOne = WalkthroughPageOneViewController()
        
        verifyViewController(pageOne)
    }
    
    func testSnapshotWalkthroughPageTwo() {
        let pageTwo = WalkthroughPageTwoViewController()
        
        verifyViewController(pageTwo)
    }
    
//    func testSnapshotWalkthroughPageThree() {
//        let pageThree = WalkthroughPageThreeViewController()
//        
//        debugViewController(pageThree)
//    }
    
    func testSnapshotWalkthroughPageFour() {
        let pageFour = WalkthroughPageFourViewController()
        
        verifyViewController(pageFour)
    }
}
