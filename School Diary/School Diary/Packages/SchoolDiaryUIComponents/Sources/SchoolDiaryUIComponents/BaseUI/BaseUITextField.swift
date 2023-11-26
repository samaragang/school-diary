//
//  BaseUITextField.swift
//
//
//  Created by Bahdan Piatrouski on 9.10.23.
//

import UIKit

open class BaseUITextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTextField()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTextField()
    }
    
    @objc public convenience init(placeholder: String? = nil) {
        self.init()
        self.placeholder = placeholder
        self.setupTextField()
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
}

// MARK: -
// MARK: Setup text field methods
extension BaseUITextField {
    @objc public func setupTextField() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray3.cgColor
        
        self.layer.cornerRadius = 20
        
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
}
