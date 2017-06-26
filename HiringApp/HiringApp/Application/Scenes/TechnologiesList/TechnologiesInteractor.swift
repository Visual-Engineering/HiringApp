//
//  TechnologiesInteractor.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred

class TechnologiesInteractor {

    //MARK: - Stored properties
    //    let repository: SceneRepositoryProtocol

    //MARK: - Initializer
    //    init(repository: SceneRepositoryProtocol = SceneRepository()) {
    //        self.repository = repository
    //    }

    let technologiesListStrings = ["ios", "android", "backend"]
}

extension TechnologiesInteractor: TechnologiesInteractorProtocol {

    func retrieveData() -> Task<TechnologiesModel> {
        let techModel = TechnologiesModel(technologies: technologiesListStrings)
        return Task(success: techModel)
    }
}
