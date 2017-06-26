//
//  CandidateModel.swift
//  Pods
//
//  Created by Alba Luján on 26/6/17.
//
//

import Foundation
import Deferred

struct CandidateModel {
    var id: Int
    var name: String
    var lastname: String
    var linkedin: String
    var phone: String
    var email: String
}

extension CandidateModel {
    func toJSON() -> Task<Data> {
        
        var dict = Dictionary<String, Any>()
        dict["id"] = self.id
        dict["name"] = self.name
        dict["lastname"] = self.lastname
        dict["linkedin"] = self.linkedin
        dict["phone"] = self.phone
        dict["email"] = self.email
        
        do {
            let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return Task(success: json)
        } catch {
            print(error.localizedDescription)
            return Task(failure: error)
        }
    }
}
