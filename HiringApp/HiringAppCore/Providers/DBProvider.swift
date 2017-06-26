//
//  DBProvider.swift
//  Pods
//
//  Created by Alba Luján on 23/6/17.
//
//

import Foundation
import RealmSwift

class Technology: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var imageURL = ""
    dynamic var testAvailable = false
    dynamic var submittedTest: Test?
}

class Test: Object {
    dynamic var status = ""
}

class DBProvider {
    
    var realm: Realm?
    
    let tech = Technology(value: [
        "id": 0,
        "title": "iOS",
        "imageURL": "",
        "testAvailable": false,
        "submittedTest": Test(value: ["status": ""])
        ])
    
    init() {
        do {  realm = try Realm()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func write() {
        try! realm?.write {
            _ = realm?.add(tech)
        }
    }
    
    func read() {
       let results = realm?.objects(Technology.self)
       print(results)
    }
    
}
