//
//  WeekDaysView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class WeekDaysView: BaseUIView {
    private lazy var weekDaysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    var weekDays: String? {
        didSet {
            self.weekDaysLabel.text = weekDays
        }
    }
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 167, height: 44)))
    }
}

// MARK: - Setup interface methods
extension WeekDaysView {
    override func setupInterface() {
        super.setupInterface()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    override func setupLayout() {
        self.addSubview(weekDaysLabel)
    }
    
    override func setupConstraints() {
        weekDaysLabel.snp.makeConstraints({ $0.centerX.centerY.equalToSuperview() })
    }
}
