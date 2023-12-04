//
//  SchoolsDiaryApi.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation
import FriendlyURLSession

enum SchoolsDiaryApi {
    case signIn(email: String, password: String)
    case teacherInfo
    case pupilInfo(id: Int)
    case schedule(weekDay: TimetableDaysType, shouldReturnHometask: Bool)
    case addHometask(schoolId: Int, classId: Int, subjectId: Int, date: Date, hometask: String)
    case getPupilsAtLesson(schoolId: Int, classId: Int, subjectId: Int, lessonDate: Date)
    case addMark(schoolId: Int, classId: Int, subjectId: Int, pupilId: Int, lessonDate: Date, mark: Int)
    case termMarks
}

extension SchoolsDiaryApi: BaseRestApiEnum {
    var baseUrl: String {
//        return "\(Constants.baseApiUrl)"
        return "https://schools-diary-api.fly.dev/api"
    }
    
    var path: String {
        switch self {
            case .signIn:
                return "/user"
            case .teacherInfo:
                return "/user/info/teacher"
            case .pupilInfo:
                return "/user/info/pupil"
            case .schedule:
                return "/user/schedule"
            case .addHometask:
                return "/hometask"
            case .getPupilsAtLesson:
                return "/lesson/pupils"
            case .addMark:
                return "/mark"
            case .termMarks:
                return "/pupil/marks/term"
        }
    }
    
    var method: FriendlyURLSession.HTTPMethod {
        switch self {
            case .addHometask, .addMark:
                return .post
            default:
                return .get
        }
    }
    
    var headers: FriendlyURLSession.Headers? {
        var headers = Headers()
        switch self {
            case .signIn:
                break
            default:
                headers["x-schools-token"] = SettingsManager.shared.account.accessToken
        }
        
        return headers
    }
    
    var parameters: FriendlyURLSession.Parameters? {
        var parameters = Parameters()
        switch self {
            case .signIn(let email, let password):
                parameters["email"] = email
                parameters["password"] = password
            case .pupilInfo(let id):
                parameters["pupil_id"] = id
            case .schedule(let weekDay, let shouldReturnHometask):
                parameters["week_day"]               = weekDay.rawValue
                parameters["should_return_hometask"] = shouldReturnHometask
            case .getPupilsAtLesson(let schoolId, let classId, let subjectId, let lessonDate):
                parameters["school_id"] = schoolId
                parameters["class_id"]  = classId
                parameters["subject_id"] = subjectId
                parameters["lesson_date"] = lessonDate.ddMMyyyyFormat
            default:
                break
        }
        
        return parameters
    }
    
    var body: JSON? {
        switch self {
            case .addHometask(let schoolId, let classId, let subjectId, let date, let hometask):
                return [
                    "schoolId": schoolId,
                    "classId": classId,
                    "subjectId": subjectId,
                    "onDate": date.ddMMyyyyFormat,
                    "hometask": hometask
                ]
            case .addMark(let schoolId, let classId, let subjectId, let pupilId, let lessonDate, let mark):
                return [
                    "schoolId": schoolId,
                    "classId": classId,
                    "subjectId": subjectId,
                    "userId": pupilId,
                    "lessonDate": lessonDate.ddMMyyyyFormat,
                    "mark": mark
                ]
            default:
                return nil
        }
    }
}
