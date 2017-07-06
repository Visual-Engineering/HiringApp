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
import HiringAppCore

class ContactFormInteractor {

    //MARK: - Stored properties
    let repository: ContactFormRepositoryProtocol
    
    //MARK: - Initializer
    init(repository: ContactFormRepositoryProtocol) {
        self.repository = repository
    }
}

extension ContactFormInteractor: ContactFormInteractorProtocol {

    func sendContactFormData(candidate: ContactFormViewModel) -> Task<()> {
        return repository.sendContactFormData(candidate: candidate.candidateModel)
    }
}
