//
//  SchoolsDiaryProvider.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation
import FriendlyURLSession

final class SchoolsDiaryProvider: BaseRestApiProvider {
    static let shared = SchoolsDiaryProvider()
    
    fileprivate init() {
        super.init(shouldPrintLog: Constants.isDebug, shouldCancelTask: false)
    }
    
    func signIn(email: String, password: String, success: @escaping((ResponseUserModel) -> ()), failure: (() -> ())? = nil) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.signIn(email: email, password: password),
                shouldPrintLog: self.shouldPrintLog)
        ) { response in
            switch response {
                case .success(let response):
                    guard let signIn = response.data?.map(to: ResponseSignInModel.self) else {
                        failure?()
                        return
                    }
                    
                    success(signIn.user)
                case .failure:
                    failure?()
            }
        }
    }
    
    func teacherInfo(success: @escaping((ResponseUserBaseModel) -> ()), failure: (() -> ())? = nil) {
        self.urlSession.dataTask(with: URLRequest(type: SchoolsDiaryApi.teacherInfo, shouldPrintLog: self.shouldPrintLog)) { response in
            switch response {
                case .success(let response):
                    guard let teacherInfo = response.data?.map(to: ResponseTeacherInfoModel.self) else {
                        failure?()
                        return
                    }
                    
                    success(teacherInfo.teacherInfo)
                case .failure:
                    failure?()
            }
        }
    }
    
    func pupilInfo(id: Int, success: @escaping((ResponseUserBaseModel) -> ()), failure: (() -> ())? = nil) {
        self.urlSession.dataTask(with: URLRequest(type: SchoolsDiaryApi.pupilInfo(id: id), shouldPrintLog: self.shouldPrintLog)) { response in
            switch response {
                case .success(let response):
                    guard let pupilInfo = response.data?.map(to: ResponseBaseContentModel<ResponseUserBaseModel>.self) else {
                        failure?()
                        return
                    }
                    
                    success(pupilInfo.content)
                case .failure:
                    failure?()
            }
        }
    }
    
    func schedule(
        for day: TimetableDaysType,
        shouldReturnHometask: Bool = false,
        success: @escaping((([ResponseLessonModel]) -> ())),
        failure: @escaping(() -> ())
    ) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.schedule(weekDay: day, shouldReturnHometask: shouldReturnHometask),
                shouldPrintLog: self.shouldPrintLog
            )
        ) { response in
            switch response {
                case .success(let response):
                    guard let lessons = response.data?.map(to: ResponseBaseContentModel<ResponseLessonsModel>.self) else {
                        failure()
                        return
                    }
                    
                    success(lessons.content.lessons)
                case .failure:
                    failure()
            }
        }
    }
    
    func addHometask(lesson: ResponseLessonModel, date: Date, hometask: String) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.addHometask(
                    schoolId: RealmManager<LocalUserModel>().read().first?.classId ?? 0,
                    classId: lesson.classId ?? 0,
                    subjectId: lesson.subjectId,
                    date: date,
                    hometask: hometask
                ), shouldPrintLog: self.shouldPrintLog
            )
        ) { _ in }
    }
    
    func getPupilsAtLesson(
        schoolId: Int,
        classId: Int,
        subjectId: Int,
        lessonDate: Date,
        success: @escaping(([ResponseShortUserInfoModel]) -> ()),
        failure: @escaping(() -> ())
    ) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.getPupilsAtLesson(
                    schoolId: schoolId,
                    classId: classId,
                    subjectId: subjectId,
                    lessonDate: lessonDate
                ),
                shouldPrintLog: self.shouldPrintLog
            )
        ) { response in
            switch response {
                case .success(let response):
                    guard let content = response.data?.map(to: ResponseBaseContentModel<ResponsePupilsModel>.self) else {
                        failure()
                        return
                    }
                    
                    success(content.content.pupils)
                case .failure:
                    failure()
            }
        }
    }
    
    func addMark(lesson: ResponseLessonModel, pupil: ResponseShortUserInfoModel, lessonDate: Date, mark: MarkType) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.addMark(
                    schoolId: RealmManager<LocalUserModel>().read().first?.schoolId ?? 0,
                    classId: lesson.classId ?? 0,
                    subjectId: lesson.subjectId,
                    pupilId: pupil.userId,
                    lessonDate: lessonDate,
                    mark: Int(mark.rawValue) ?? 0
                ),
                shouldPrintLog: self.shouldPrintLog
            ),
            response: { _ in }
        )
    }
    
    func termMarks(success: @escaping(([ResponseSubjectMarkModel]) -> ()), failure: (() -> ())? = nil) {
        self.urlSession.dataTask(with: URLRequest(type: SchoolsDiaryApi.termMarks, shouldPrintLog: self.shouldPrintLog)) { response in
            switch response {
                case .success(let response):
                    guard let marks = response.data?.map(to: ResponseBaseContentModel<ResponseSubjectMarksModel>.self) else {
                        failure?()
                        return
                    }
                    
                    success(marks.content.subjects)
                case .failure:
                    failure?()
            }
        }
    }
}
