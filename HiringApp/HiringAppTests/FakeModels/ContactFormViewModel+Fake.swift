//
//  ContactFormViewModel+Fake.swift
//  HiringApp
//
//  Created by Margareta Kusan on 04/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
@testable import HiringApp

extension ContactFormViewModel {
    static var fakeValid: ContactFormViewModel {
        return ContactFormViewModel (
            name: "Alejandro",
            lastname: "García",
            linkedin: "https://www.linkedin.com/...",
            phone: "666777888",
            email: "agarcia@visualengin.com"
        )
    }
    
    static var fakeInValid: ContactFormViewModel {
        return ContactFormViewModel (
            name: "Alejandro",
            lastname: "García",
            linkedin: "",
            phone: "666777888",
            email: ""
        )
    }
}
