//
//  LessonMarksPresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

protocol LessonMarksPresenterProtocol {
    func viewDidLoad()
    func viewWillDisappear()
    func user(for indexPath: IndexPath) -> ResponseShortUserInfoModel
    func didSelect(at indexPath: IndexPath)
    
    var usersCount: Int { get }
}

fileprivate struct PupilMarkModel {
    let userId: Int
    var mark: MarkType
}

final class LessonMarksPresenter: LessonMarksPresenterProtocol {
    private let lesson: ResponseLessonModel
    private let lessonDate: Date
    private let view: LessonMarksViewControllerProtocol
    private var pupils = [ResponseShortUserInfoModel]() {
        didSet {
            self.view.reloadData()
        }
    }
    
    private var pupilMarks = [PupilMarkModel]()
    
    var usersCount: Int {
        return pupils.count
    }
    
    init(lesson: ResponseLessonModel, date: Date, view: LessonMarksViewControllerProtocol) {
        self.lesson = lesson
        self.lessonDate = date
        self.view = view
    }
    
    func viewDidLoad() {
        self.fetchPupils()
    }
    
    func viewWillDisappear() {
        self.pupilMarks.forEach { [weak self] pupilMark in
            guard let self,
                  let pupil = self.pupils.first(where: { $0.userId == pupilMark.userId })
            else { return }
            
            SchoolsDiaryProvider.shared.addMark(lesson: self.lesson, pupil: pupil, lessonDate: self.lessonDate, mark: pupilMark.mark)
        }
    }
    
    private func fetchPupils() {
        SchoolsDiaryProvider.shared.getPupilsAtLesson(
            schoolId: RealmManager<LocalUserModel>().read().first?.schoolId ?? 0,
            classId: lesson.classId ?? 0,
            subjectId: lesson.subjectId,
            lessonDate: lessonDate
        ) { [weak self] users in
            self?.pupils = users
        } failure: { [weak self] in
            self?.view.popViewController()
        }
    }
    
    func user(for indexPath: IndexPath) -> ResponseShortUserInfoModel {
        return self.pupils[indexPath.row]
    }
    
    func didSelect(at indexPath: IndexPath) {
        let user = self.pupils[indexPath.row]
        MainCoordinator.shared.pushChooseMarkViewController(pupil: user) { [weak self] mark in
            let userId = user.userId
            if var markObject = self?.pupilMarks.first(where: { $0.userId == userId }) {
                markObject.mark = mark
            } else {
                self?.pupilMarks.append(PupilMarkModel(userId: userId, mark: mark))
            }
            
            self?.view.updateMark(at: indexPath, with: mark)
        }
    }
}
