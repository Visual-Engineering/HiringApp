//
//  TechSelectionInteractor.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

class TechSelectionInteractor {

    //MARK: - Stored properties
        let repository: TechnologiesRepository

    //MARK: - Initializer
        init(repository: TechnologiesRepository = TechnologiesRepository()) {
            self.repository = repository
        }

}

extension TechSelectionInteractor: TechSelectionInteractorProtocol {

    func retrieveData() -> Task<[TechnologyModel]> {
       return repository.retrieveTechnologiesList()
    }
}
