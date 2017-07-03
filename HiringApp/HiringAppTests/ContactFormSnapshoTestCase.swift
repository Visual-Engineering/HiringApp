//
//  ContactFormSnapshoTestCase.swift
//  
//
//  Created by Alba Luján on 28/6/17.
//
//

import XCTest
@testable import HiringApp

class ContactFormSnapshoTestCase: SnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testContactForm() {
        let contactvc = ContactFormBuilder.build()
        let nav = UINavigationController(rootViewController: contactvc)
        debugViewController(nav)
    }
}
