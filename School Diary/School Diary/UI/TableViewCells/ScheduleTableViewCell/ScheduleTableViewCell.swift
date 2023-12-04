//
//  ScheduleTableViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 26.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class ScheduleTableViewCell: BaseUITableViewCell {
    static var cellHeight: CGFloat {
        return ScheduleTableViewCell(style: .default, reuseIdentifier: ScheduleTableViewCell.id).frame.height
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .sfMonoRegular(size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var homeworkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "с.13 упр.10-16"
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(subjectLabel)
        stackView.addArrangedSubview(homeworkLabel)
        return stackView
    }()
    
    private lazy var auditoriumLabel: UILabel = {
        let label = UILabel()
        label.font = .sfMonoRegular(size: 14)
        label.text = "101"
        label.textAlignment = .right
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.timeLabel.text = nil
        self.subjectLabel.text = nil
        self.auditoriumLabel.text = nil
        self.homeworkLabel.text = nil
        self.homeworkLabel.layer.opacity = 1
    }
    
    func configure(withLesson lesson: ResponseLessonModel, forDate: Date) {
        self.timeLabel.text = lesson.time.replacingOccurrences(of: "-", with: " -\n")
        self.subjectLabel.text = lesson.lesson
        self.auditoriumLabel.text = lesson.auditorium
        let currentUserRole = RealmManager<LocalUserModel>().read().first?.role
        switch currentUserRole {
            case .teacher:
                guard let className = lesson.className else {
                    self.homeworkLabel.layer.opacity = 0
                    return
                }
                
                self.homeworkLabel.text = className
            case .pupil:
                guard let hometask = lesson.hometasks?.first(where: { $0.onDate == forDate.ddMMyyyyFormat })?.hometask else {
                    self.homeworkLabel.layer.opacity = 0
                    return
                }
                
                self.homeworkLabel.text = hometask
            default:
                self.homeworkLabel.layer.opacity = 0
        }
    }
}

// MARK: -
// MARK: Setup interface methods
extension ScheduleTableViewCell {
    override func setupInterface() {
        super.setupInterface()
        guard RealmManager<LocalUserModel>().read().first?.role == .pupil else { return }
        
        self.selectionStyle = .none
    }
    
    override func setupLayout() {
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(verticalStackView)
        self.contentView.addSubview(auditoriumLabel)
    }
    
    override func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(76)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(self.timeLabel.snp.trailing).offset(17)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        auditoriumLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalTo(self.verticalStackView.snp.trailing).offset(42)
        }
        
        self.contentView.layoutIfNeeded()
    }
}

@available(iOS 17.0, *)
#Preview {
    return ScheduleTableViewCell(style: .default, reuseIdentifier: ScheduleTableViewCell.id)
}
