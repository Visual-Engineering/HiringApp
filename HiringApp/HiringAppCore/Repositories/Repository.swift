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

public class Repository {
    
    //MARK: - Stored properties
    let apiProvider: APIProviderType
    let cacheProvider: CacheProviderType
    let dbProvider: DBProviderType
    
    init(apiProvider: APIProviderType, cacheProvider: CacheProviderType, dbProvider: DBProviderType) {
        self.apiProvider = apiProvider
        self.cacheProvider = cacheProvider
        self.dbProvider = dbProvider
    }
    
    func retrieveAPITechnologies() -> Task<[TechnologyModel]> {
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
                techList.append(tech.toModel)
            })
            return Task(success: techList)
            
        } else {
            let techTask = apiProvider.retrieveTechnologies().andThen(upon: .main) { (modelsArray) -> Task<[TechnologyModel]> in
                modelsArray.forEach({ (tech) in
                    _ = self.dbProvider.write(tech: tech.toRealmModel)
                })
                return Task(success: modelsArray)
           }
        
            return techTask
        }
    }
}

