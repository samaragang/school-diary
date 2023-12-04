//
//  SubjectMarksTableViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

final class SubjectMarksTableViewCell: BaseUITableViewCell {
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var marksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "9, 8, 7"
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(subjectLabel)
        stackView.addArrangedSubview(marksLabel)
        return stackView
    }()
    
    private lazy var averageMarkLabel: UILabel = {
        let label = UILabel()
        label.font = .sfMonoRegular(size: 14)
        label.text = "101"
        label.textAlignment = .right
        return label
    }()
    
    func configure(subject: ResponseSubjectMarkModel) {
        self.subjectLabel.text = subject.subjectName
        self.marksLabel.text = subject.marks
        if let averageMark = subject.averageMark {
            self.averageMarkLabel.text = "\(averageMark)"
        } else {
            self.averageMarkLabel.isHidden = true
        }
    }
}

// MARK: - Setup interface methods
extension SubjectMarksTableViewCell {
    override func setupInterface() {
        super.setupInterface()
        self.selectionStyle = .none
    }
    
    override func setupLayout() {
        self.contentView.addSubview(verticalStackView)
        self.contentView.addSubview(averageMarkLabel)
    }
    
    override func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 8))
            make.leading.equalToSuperview().offset(12)
        }
        
        averageMarkLabel.snp.makeConstraints { make in
            make.centerY.equalTo(verticalStackView.snp.centerY)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
