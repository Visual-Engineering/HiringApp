//
//  RoundedButton.swift
//  HiringApp
//
//  Created by Margareta Kusan on 06/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation

class RoundedButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = rect.height * 0.5
        self.clipsToBounds = true
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            if let color = self.titleColor(for: .normal) {
                if isEnabled {
                    self.setStyledTitleColor(color.withAlphaComponent(1))
                } else {
                    self.setStyledTitleColor(color.withAlphaComponent(0.5))
                }
            }
        }
    }
}
