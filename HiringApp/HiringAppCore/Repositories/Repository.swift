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
    let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    func retrieveTechnologies() -> Task<[TechnologyModel]> {
        return apiProvider.retrieveTechnologies()
    }
}

