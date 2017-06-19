//
//  TechSelectionInteractor.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred

class TechSelectionInteractor {

    //MARK: - Stored properties
    //    let repository: SceneRepositoryProtocol

    //MARK: - Initializer
    //    init(repository: SceneRepositoryProtocol = SceneRepository()) {
    //        self.repository = repository
    //    }

}

extension TechSelectionInteractor: TechSelectionInteractorProtocol {

    func retrieveData() -> Task<[TechnologyModel]> {
        let technologies = [
            TechnologyModel(id: 1, title: "iOS", imageURL: "https://images/ios.png", testAvailable: true),
            TechnologyModel(id: 2, title: "Android", imageURL: "https://images/android.png", testAvailable: false),
            TechnologyModel(id: 3, title: "Frontend", imageURL: "https://images/frontend.png", testAvailable: false),
            TechnologyModel(id: 4, title: "Backend", imageURL: "https://images/backend.png", testAvailable: false),

        ]

        return Task(success: technologies)
    }
}
