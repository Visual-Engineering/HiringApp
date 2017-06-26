//
//  TechnologyRealm.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import RealmSwift


public class TechnologyRealm: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var imageURL = ""
    dynamic var testAvailable = false
    dynamic var submittedTest: Test?
}

public class Test: Object {
    dynamic var status = ""
}
