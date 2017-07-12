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

public protocol CacheProviderType {
    func getTechnologies() -> [TechnologyModel]?
    func saveTechnologies(technologies: [TechnologyModel]) -> Task<()>
    func getTopics() -> [TopicModel]?
    func saveTopics(_ topics: [TopicModel]) -> Task<()>
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
        _ = technologies.map { (tech) in
            technologiesStorable.append(tech.technologiestoDict())
        }
        
        defaults.setValue(technologiesStorable, forKey: "technologies")
        deferred.fill(with: .success(()))
        
        return Task(future: Future(deferred))
    }
    
    func removeTechnologies() {
        defaults.removeObject(forKey: "technologies")
    }
    
    func getTopics() -> [TopicModel]? {
        guard let storedTopics = defaults.array(forKey: "topics") as? [[String:Any]] else {
            return nil
        }
        
        var topicsConverted = [TopicModel]()
        storedTopics.forEach { (topic) in
            let id = topic["id"] as! Int
            let title = topic["title"] as! String
            let technologyId = topic["technologyId"] as! Int
            
            let topic = TopicModel(topicId: id,
                                   title: title,
                                   technologyId: technologyId)
            topicsConverted.append(topic)
        }
        return topicsConverted
    }
    
    func saveTopics(_ topics: [TopicModel]) -> Task<()> {
        let deferred = Deferred<TaskResult<()>>()
        
        var topicsStorable = [[String: Any]]()
        _ = topics.map { (topic) in
            topicsStorable.append(topic.topicsToDict())
        }
        
        defaults.setValue(topicsStorable, forKey: "topics")
        deferred.fill(with: .success(()))
        
        return Task(future: Future(deferred))

    }
}

extension TechnologyModel {
    func technologiestoDict() -> [String: Any] {
        
        let otherSelf = Mirror(reflecting: self)
        
        let optionalKeys = otherSelf.children.flatMap { (child) -> String? in
            if String(describing: type(of: child.value)).contains("Optional") {
                return child.label!
            }
            return nil
        }

        var dict = [String:Any]()
        for child in otherSelf.children {
            if let key = child.label {
                if optionalKeys.contains(key) {
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
