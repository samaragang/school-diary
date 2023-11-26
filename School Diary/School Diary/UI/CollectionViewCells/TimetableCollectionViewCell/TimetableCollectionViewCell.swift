//
//  TimetableCollectionViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class TimetableCollectionViewCell: BaseUICollectionViewCell {
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 32, weight: .black)
        return label
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.addSubview(dayLabel)
        return view
    }()
    
    func configure(withDay: TimetableDaysType) {
        self.baseView.backgroundColor = withDay.backgroundColor
        self.dayLabel.text = withDay.title
    }
}

// MARK: - Setup interface
extension TimetableCollectionViewCell {
    override func setupLayout() {
        self.addSubview(baseView)
    }
    
    override func setupConstraints() {
        baseView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        dayLabel.snp.makeConstraints({ $0.centerX.centerY.equalToSuperview() })
    }
}
