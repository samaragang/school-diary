//
//  BaseUITableViewCell.swift
//
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

open class BaseUITableViewCell: UITableViewCell {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupInterface()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupInterface()
    }
}

// MARK: - Setup interface methods
extension BaseUITableViewCell {
    @objc open func setupInterface() {
        self.setupLayout()
        self.setupConstraints()
    }
    
    @objc open func setupLayout() {}
    @objc open func setupConstraints() {}
}
