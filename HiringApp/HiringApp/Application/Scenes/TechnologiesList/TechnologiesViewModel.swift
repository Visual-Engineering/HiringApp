//
//  TechnologiesViewModel.swift
//  HiringApp
//
//  Created by Pia Muñoz on 23/6/17.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

struct TechnologiesViewModel {
    let technologies: [String]
}

struct TechnologiesModel {
    let technologies: [String]
}

extension TechnologiesViewModel {
    init(fromModel model: TechnologiesModel) {
        self.technologies = model.technologies
    }
}
