//
//  File.swift
//  
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

extension UITextField {
    @objc public convenience init(placeholder: String? = nil) {
        self.init()
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
