//
//  PupilMarkTableViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

final class PupilMarkTableViewCell: BaseUITableViewCell {
    private lazy var pupilLabel: UILabel = {
        let label = UILabel()
        label.text = "Антонова Мария"
        label.textColor = .black
        return label
    }()
    
    private lazy var markLabel: LabelInView = {
        let label = LabelInView()
        label.text = self.selectedMark.rawValue
        label.font = .systemFont(ofSize: 18, weight: .medium)
        if let color = self.selectedMark.color {
            label.backgroundColor = self.selectedMark.color
        } else {
            label.backgroundColor = self.dayType?.backgroundColor.withAlphaComponent(0.3)
        }
        
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.addSubview(pupilLabel)
        view.addSubview(markLabel)
        return view
    }()
    
    private var dayType: TimetableDaysType? {
        didSet {
            guard self.selectedMark == .none else { return }
            
            self.markLabel.backgroundColor = self.dayType?.backgroundColor.withAlphaComponent(0.3)
        }
    }
    
    private var selectedMark: MarkType = .none {
        didSet {
            self.markLabel.text = selectedMark.rawValue
            if let color = selectedMark.color {
                self.markLabel.backgroundColor = color
            } else {
                self.markLabel.backgroundColor = self.dayType?.backgroundColor.withAlphaComponent(0.3)
            }
        }
    }
    
    private var user: ResponseShortUserInfoModel? {
        didSet {
            self.pupilLabel.text = user?.nameAndSurname
        }
    }
    
    func configure(user: ResponseShortUserInfoModel, dayType: TimetableDaysType) {
        self.backgroundColor = .clear
        self.dayType = dayType
        self.user = user
        self.selectedMark = user.mark
    }
    
    func updateMark(_ mark: MarkType) {
        self.selectedMark = mark
    }
}

// MARK: - Setup interface methods
extension PupilMarkTableViewCell {
    override func setupInterface() {
        super.setupInterface()
        self.selectionStyle = .none
    }
    
    override func setupLayout() {
        self.contentView.addSubview(mainView)
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 12, vertical: 8)) })
        
        pupilLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(UIEdgeInsets(horizontal: 16, vertical: 15))
        }
        
        markLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 11))
            make.trailing.equalToSuperview().offset(-19)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
    }
}
