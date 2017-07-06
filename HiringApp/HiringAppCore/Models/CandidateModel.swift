//
//  CandidateModel.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation

public struct CandidateModel {
    public let name: String
    public let lastname: String
    public let linkedin: String
    public let phone: String
    public let email: String
    
    public init(name: String, lastname: String, linkedin: String?, phone: String, email: String) {
        self.name = name
        self.lastname = lastname
        self.linkedin = linkedin ?? ""
        self.phone = phone
        self.email = email
    }
}

extension CandidateModel {
    var dict: [String : Any] {
        return [
            "name" : self.name,
            "lastname" : self.lastname,
            "linkedin" : self.linkedin,
            "phone" : self.phone,
            "email" : self.email
        ]
    }
}
