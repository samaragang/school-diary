//
//  LabelInView.swift
//
//
//  Created by Bahdan Piatrouski on 26.11.23.
//

import UIKit
import SnapKit

open class LabelInView: BaseUIView {
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    public var text: String? {
        didSet {
            self.mainLabel.text = text
        }
    }
    
    public var font: UIFont? = .systemFont(ofSize: 17, weight: .semibold) {
        didSet {
            self.mainLabel.font = font
        }
    }
}

// MARK: - Setup interface methods
extension LabelInView {
    open override func setupInterface() {
        super.setupInterface()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    open override func setupLayout() {
        self.addSubview(mainLabel)
    }
    
    open override func setupConstraints() {
        mainLabel.snp.makeConstraints({ $0.centerX.centerY.equalToSuperview() })
    }
}
