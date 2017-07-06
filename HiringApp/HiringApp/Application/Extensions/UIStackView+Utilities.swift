//
//  UIStackView+Utilities.swift
//  HiringApp
//
//  Created by Pablo Balduz on 26/6/17.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func clear() {
        self.subviews.forEach { subview in
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
