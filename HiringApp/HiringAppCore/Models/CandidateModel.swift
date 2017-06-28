//
//  CandidateModel.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation

struct CandidateModel {
    var id: Int
    var name: String
    var lastname: String
    var linkedin: String
    var phone: String
    var email: String
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
