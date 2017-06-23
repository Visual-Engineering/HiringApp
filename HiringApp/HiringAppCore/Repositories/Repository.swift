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

class Repository {
    
    //MARK: - Stored properties
    let apiProvider: APIProviderType
    let cacheProvider: CacheProviderType
    
    init(apiProvider: APIProviderType, cacheProvider: CacheProviderType) {
        self.apiProvider = apiProvider
        self.cacheProvider = cacheProvider
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
    
}

