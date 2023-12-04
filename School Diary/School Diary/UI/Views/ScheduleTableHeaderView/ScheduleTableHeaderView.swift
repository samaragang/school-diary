//
//  ScheduleTableHeaderView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 26.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class ScheduleTableHeaderView: BaseUIView {
    private lazy var colorTopView: UIView = {
        let view = UIView()
        view.backgroundColor = self.topColor
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Время"
        return label
    }()
    
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Предмет / Задание"
        return label
    }()
    
    private lazy var auditoriumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Кабинет"
        return label
    }()
    
    var topColor: UIColor? = UIColor(red: 0.48, green: 0.33, blue: 1, alpha: 1) {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.colorTopView.backgroundColor = self?.topColor
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -
// MARK: Setup interface methods
extension ScheduleTableHeaderView {
    override func setupLayout() {
        self.addSubview(colorTopView)
        self.addSubview(timeLabel)
        self.addSubview(subjectLabel)
        self.addSubview(auditoriumLabel)
    }
    
    override func setupConstraints() {
        colorTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(colorTopView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(colorTopView.snp.bottom).offset(10)
            make.leading.equalTo(timeLabel.snp.trailing).offset(15)
        }
        
        auditoriumLabel.snp.makeConstraints { make in
            make.top.equalTo(colorTopView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalTo(subjectLabel.snp.trailing).offset(19)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    return ScheduleTableHeaderView()
}
