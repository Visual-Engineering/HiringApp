//
//  DBProvider.swift
//  Pods
//
//  Created by Alba Luján on 23/6/17.
//
//

import Foundation
import RealmSwift
import Deferred

enum DBErrors: Error {
    case unableToWrite
}

public protocol DBProviderType {
    func write(tech: TechnologyRealm) -> Task<()>
    func read() -> [TechnologyRealm]?
}

class DBProvider: DBProviderType {
    
    var realm: Realm
    
    init?() {
        guard let realm = try? Realm() else {
            return nil
        }
        self.realm = realm
    }
    
    func write(tech: TechnologyRealm) -> Task<()> {
        let deferred = Deferred<TaskResult<()>>()

        do {
            try realm.write {
                _ = realm.add(tech)
            }
            deferred.fill(with: .success(()))
        } catch {
            deferred.fill(with: .failure(RepositoryError.cantSave))
        }
        
        return Task(future: Future(deferred))
    }
    
    func read() -> [TechnologyRealm]? {
        let results = realm.objects(TechnologyRealm.self)
        var technologies = [TechnologyRealm]()
        results.forEach({ (tech) in
            technologies.append(tech)
        })
        return technologies
    }
    
    func clearAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}

