//
//  PupilViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit
import SchoolDiaryUIComponents

protocol PupilViewControllerProtocol: BaseUIViewControllerProtocol {
    func updateTeacherInfo()
}

final class PupilViewController: UserViewController {
    private lazy var teacherInfoModel = TeacherInfoView()
    
    private let presenter: PupilPresenterProtocol
    
    override init() {
        self.presenter = PupilPresenter()
        super.init()
        self.presenter.setView(self)
        self.presenter.fetchTeacherInfoIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension PupilViewController {
    override func setupLayout() {
        super.setupLayout()
        self.view.addSubview(teacherInfoModel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        teacherInfoModel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-38)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - PupilViewControllerProtocol
extension PupilViewController: PupilViewControllerProtocol {
    func updateTeacherInfo() {
        self.teacherInfoModel.updateTeacherInfo()
    }
}
