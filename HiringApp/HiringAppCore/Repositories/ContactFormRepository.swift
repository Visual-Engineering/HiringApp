//
//  ContactFormRepository.swift
//  Pods
//
//  Created by Margareta Kusan on 03/07/2017.
//
//

import Foundation
import Deferred
import BSWFoundation

public protocol ContactFormRepositoryProtocol {
    func sendContactFormData(candidate: CandidateModel) -> Task<()>
}

public class ContactFormRepository {
    
    //MARK: - Stored properties
    let apiProvider: APIProviderType
    let deviceID: String? = UIDevice.current.identifierForVendor?.uuidString
    
    public init?(apiProvider: APIProviderType = APIProvider()) {        
        self.apiProvider = apiProvider
    }
}

extension ContactFormRepository: ContactFormRepositoryProtocol {
    
    public func sendContactFormData(candidate: CandidateModel) -> Task<()> {
        let techTask = apiProvider.performContact(candidate: candidate).andThen(upon: .main) { _ in
            return Task(success: ())
        }
        return techTask
    }
}
