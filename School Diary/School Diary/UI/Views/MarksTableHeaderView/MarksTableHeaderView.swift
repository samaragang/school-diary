//
//  MarksTableHeaderView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

final class MarksTableHeaderView: BaseUIView {
    private lazy var colorTopView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.59, green: 0.85, blue: 0.27, alpha: 1)
        return view
    }()
    
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Предмет"
        return label
    }()
    
    private lazy var markLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Итоговая отметка"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension MarksTableHeaderView {
    override func setupLayout() {
        self.addSubview(colorTopView)
        self.addSubview(subjectLabel)
        self.addSubview(markLabel)
    }
    
    override func setupConstraints() {
        colorTopView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.top.equalTo(colorTopView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
        }
        
        markLabel.snp.makeConstraints { make in
            make.top.equalTo(colorTopView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
