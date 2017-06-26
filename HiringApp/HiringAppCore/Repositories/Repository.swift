//
//  TechnologiesRepository.swift
//  Pods
//
//  Created by Alba Luján on 21/6/17.
//
//

import Foundation
import Deferred
import BSWFoundation

enum RepositoryError: Error {
    case noData
    case cantSave
}

class Repository {
    
    //MARK: - Stored properties
    let apiProvider: APIProviderType
    let cacheProvider: CacheProviderType
    let dbProvider: DBProviderType
    
    init(apiProvider: APIProviderType, cacheProvider: CacheProviderType, dbProvider: DBProviderType) {
        self.apiProvider = apiProvider
        self.cacheProvider = cacheProvider
        self.dbProvider = dbProvider
    }
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        if let technologies = cacheProvider.getTechnologies() {
            return Task(success: technologies)
        }
                
        let techTask = apiProvider.retrieveTechnologies().andThen(upon: .main) { (modelsArray) -> Task<[TechnologyModel]> in
            return self.cacheProvider
                .saveTechnologies(technologies: modelsArray) //Save modelsArray into cache
                .recover(upon: .main, substituting: { (_) in })
                .map(upon: .main, transform: { (_) -> [TechnologyModel] in
                    return modelsArray
                })
        }
        
        return techTask
    }
    
    func retrieveDBTechnologies() -> Task<[TechnologyModel]> {
        
        var techList = [TechnologyModel]()
        
        if let technologies = dbProvider.read() {
            technologies.forEach({ (tech) in
                guard let techModel: TechnologyModel = tech.transformToTechnologyModel() else {
                    return
                }
                techList.append(techModel)
            })
            
            return Task(success: techList)
            
        } else {
            
            let techTask = apiProvider.retrieveTechnologies().andThen(upon: .main) { (modelsArray) -> Task<[TechnologyModel]> in
                
                modelsArray.forEach({ (tech) in
                    guard let techRealm = tech.transformToTechnologyRealm() else {
                        return
                    }
                    _ = self.dbProvider.write(tech: techRealm)
                })
                
                return Task(success: modelsArray)
           }
        
            return techTask
        }
    }
}

