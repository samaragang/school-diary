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
    
    func signIn(email: String, password: String, success: @escaping((ResponseUserModel) -> ()), failure: @escaping(() -> ())) {
        self.urlSession.dataTask(
            with: URLRequest(
                type: SchoolsDiaryApi.signIn(email: email, password: password),
                shouldPrintLog: self.shouldPrintLog)
        ) { response in
            switch response {
                case .success(let response):
                    guard let signIn = response.data?.map(to: ResponseSignInModel.self) else {
                        failure()
                        return
                    }
                    
                    success(signIn.user)
                case .failure:
                    failure()
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
}
