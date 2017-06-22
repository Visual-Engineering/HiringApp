//
//  CacheProvider.swift
//  Pods
//
//  Created by Alba Luján on 22/6/17.
//
//

import Foundation
import BSWFoundation
import Deferred

protocol CacheProviderType {
    func getTechnologies() -> [TechnologyModel]?
    func saveTechnologies(technologies: [TechnologyModel]) -> Task<()>
}

class CacheProvider: CacheProviderType {
    
    let defaults = UserDefaults.standard
    let technologies: [TechnologyModel]? = nil
    
    func getTechnologies() -> [TechnologyModel]? {
        guard let storedTechnologies = defaults.array(forKey: "technologies") as? [[String:Any]] else {
            return nil
        }
        
        var technologiesConverted = [TechnologyModel]()
        storedTechnologies.forEach { (technology) in
            let tech = TechnologyModel(id: technology["id"] as! Int, title: technology["title"] as! String, imageURL: technology["imageURL"] as! String, testAvailable: technology["testAvailable"] as! Bool, submittedTest: technology["submittedTest"] as? [String : String])
            technologiesConverted.append(tech)
        }
        return technologiesConverted
    }

    func saveTechnologies(technologies: [TechnologyModel]) -> Task<()> {
        let deferred = Deferred<TaskResult<()>>()
        
        var technologiesStorable = [[String: Any]]()
        technologies.forEach { (tech) in
            technologiesStorable.append(tech.toDict())
        }

        defaults.setValue(technologiesStorable, forKey: "technologies")
        deferred.fill(with: .success(()))
        
        return Task(future: Future(deferred))
    }
}

extension TechnologyModel {
    func toDict() -> [String: Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if key == "submittedTest" {
                    if let _ = child.value as? Dictionary<String, Any> {
                        dict[key] = child.value
                    }
                } else {
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
}
