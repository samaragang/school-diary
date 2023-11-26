//
//  PupilPresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import Foundation

protocol PupilPresenterProtocol {
    func fetchTeacherInfoIfNeeded()
    
    func setView(_ view: PupilViewControllerProtocol?)
}

final class PupilPresenter: PupilPresenterProtocol {
    private weak var view: PupilViewControllerProtocol?
    
    init() {}
    
    func setView(_ view: PupilViewControllerProtocol?) {
        self.view = view
    }
    
    func fetchTeacherInfoIfNeeded() {
        guard RealmManager<LocalTeacherModel>().read().isEmpty else { return }
        
        SchoolsDiaryProvider.shared.teacherInfo { [weak self] teacher in
            let teacherModel = LocalTeacherModel(teacher: teacher)
            RealmManager<LocalTeacherModel>().write(object: teacherModel)
            self?.view?.updateTeacherInfo()
        }
    }
}
