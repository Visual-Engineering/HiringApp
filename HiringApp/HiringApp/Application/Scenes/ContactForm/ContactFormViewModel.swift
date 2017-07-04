//
//  ContactFormViewModel.swift
//  HiringApp
//
//  Created by Alba Luján on 28/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import HiringAppCore

struct ContactFormViewModel {
    
    //MARK: - Stored properties
    var name: String
    var lastname: String
    var linkedin: String
    var phone: String
    var email: String
}

extension ContactFormViewModel {
    var candidateModel: CandidateModel {
        return CandidateModel(
            name: self.name,
            lastname: self.lastname,
            linkedin: self.linkedin,
            phone: self.phone,
            email: self.email
        )
    }
}

extension ContactFormViewModel {
    init() {
        self.name = ""
        self.lastname = ""
        self.linkedin = ""
        self.phone = ""
        self.email = ""
    }
    
    func validate() -> Bool {
        return nameIsValid() && lastnameIsValid() && phoneIsValid() && emailIsValid()
    }
    
    func nameIsValid() -> Bool  {
        return !name.isEmpty
    }
    
    func lastnameIsValid() -> Bool {
        return !lastname.isEmpty
    }
    
    func linkedInIsValid() -> Bool {
        guard let url = URL(string: linkedin), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
    
    func phoneIsValid() -> Bool {
        guard phone.characters.count > 0 else {
            return false
        }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(phone.characters).isSubset(of: nums)
    }
    
    func emailIsValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

extension ContactFormViewModel: Equatable {
    public static func ==(lhs: ContactFormViewModel, rhs: ContactFormViewModel) -> Bool {
        let name = (lhs.name == rhs.name)
        let lastname = (lhs.lastname == rhs.lastname)
        let linkedin = (lhs.linkedin == rhs.linkedin)
        let phone = (lhs.phone == rhs.phone)
        let email = (lhs.email == rhs.email)
        
        return name && lastname && linkedin && phone && email
    }
}
