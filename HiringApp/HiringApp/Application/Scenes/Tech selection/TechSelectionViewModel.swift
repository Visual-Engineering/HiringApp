//
//  TechSelectionViewModel.swift
//  HiringApp
//
//  Created by Alejandro Garcia on 19/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

struct TechSelectionViewModel {

    //MARK: - Stored properties
    let title: String
    let techs: [TechnologyViewModel]
}

struct TechnologyViewModel {

    //MARK: - Stored properties
    let id: Int
    let title: String
    let imageURL: String?
    let testAvailable: Bool
}
