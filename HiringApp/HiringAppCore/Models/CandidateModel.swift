//
//  CandidateModel.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation

public struct CandidateModel {
    public let id: Int
    public let name: String
    public let lastname: String
    public let linkedin: String
    public let phone: String
    public let email: String
}

extension CandidateModel {
    var dict: [String : Any] {
        return [
            "id" : self.id,
            "name" : self.name,
            "lastname" : self.lastname,
            "linkedin" : self.linkedin,
            "phone" : self.phone,
            "email" : self.email
        ]
    }
}
