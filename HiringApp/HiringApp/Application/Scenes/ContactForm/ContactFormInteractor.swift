//
//  ContactFormInteractor.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import Deferred
import BSWFoundation

class ContactFormInteractor {

    //MARK: - Stored properties
    //    let repository: SceneRepositoryProtocol

    //MARK: - Initializer
    //    init(repository: SceneRepositoryProtocol = SceneRepository()) {
    //        self.repository = repository
    //    }

}

extension ContactFormInteractor: ContactFormInteractorProtocol {

    func sendContactFormData() -> Task<()> {
        return undefined()
    }
}
