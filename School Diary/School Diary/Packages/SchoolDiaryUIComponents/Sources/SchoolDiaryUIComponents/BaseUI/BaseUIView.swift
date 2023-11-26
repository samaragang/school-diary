//
//  BaseUIView.swift
//
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

open class BaseUIView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupInterface()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupInterface()
    }
}

// MARK: - Setup interface methods
extension BaseUIView {
    @objc open func setupInterface() {
        self.setupLayout()
        self.setupConstraints()
    }
    
    @objc open func setupLayout() {}
    @objc open func setupConstraints() {}
}
