//
//  DBProvider.swift
//  Pods
//
//  Created by Alba Luján on 23/6/17.
//
//

import Foundation
import RealmSwift

class DBProvider {
    
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func write(tech: TechnologyRealm) {
        try! realm?.write {
            _ = realm?.add(tech)
        }
    }
    
    func read() -> [TechnologyRealm]? {
        let results = realm?.objects(TechnologyRealm.self)
        var technologies = [TechnologyRealm]()
        results?.forEach({ (tech) in
            technologies.append(tech)
        })
        return technologies
    }
    
    func clearAll() {
        try! realm?.write {
            realm?.deleteAll()
        }
    }
    
}

