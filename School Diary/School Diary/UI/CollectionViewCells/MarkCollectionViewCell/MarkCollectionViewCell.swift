//
//  MarkCollectionViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

final class MarkCollectionViewCell: BaseUICollectionViewCell {
    private lazy var markLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .black)
        return label
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.addSubview(markLabel)
        view.layer.cornerRadius = 16
        return view
    }()
    
    func configure(withMark mark: MarkType) {
        self.baseView.backgroundColor = mark.color
        self.markLabel.text = mark.rawValue
    }
}

// MARK: - Setup interface
extension MarkCollectionViewCell {
    override func setupLayout() {
        self.addSubview(baseView)
    }
    
    override func setupConstraints() {
        baseView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        markLabel.snp.makeConstraints({ $0.centerX.centerY.equalToSuperview() })
    }
}
