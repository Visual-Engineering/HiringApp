//
//  TechnologiesInteractor.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import HiringAppCore

class TechnologiesInteractor {

    // MARK: - Stored properties
    let repository: TechsRepositoryProtocol

    // MARK: - Initializer
    init(repository: TechsRepositoryProtocol) {
        self.repository = repository
    }
}

extension TechnologiesInteractor: TechnologiesInteractorProtocol {

    func retrieveData() -> Task<[TechnologyModel]> {
        return repository.retrieveAPITechnologies()
    }
}


