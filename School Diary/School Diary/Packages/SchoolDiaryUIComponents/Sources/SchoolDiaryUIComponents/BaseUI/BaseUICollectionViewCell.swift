//
//  BaseUICollectionViewCell.swift
//
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit

open class BaseUICollectionViewCell: UICollectionViewCell {
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
extension BaseUICollectionViewCell {
    @objc open func setupInterface() {
        self.setupLayout()
        self.setupConstraints()
    }
    
    @objc open func setupLayout() {}
    @objc open func setupConstraints() {}
}
