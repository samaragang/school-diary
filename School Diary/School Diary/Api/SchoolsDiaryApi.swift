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
}

extension SchoolsDiaryApi: BaseRestApiEnum {
    var baseUrl: String {
        return "http://localhost:8000/api"
//        return "https://schools-diary-api.fly.dev/api"
    }
    
    var path: String {
        switch self {
            case .signIn:
                return "/user"
            case .teacherInfo:
                return "/user/info/teacher"
        }
    }
    
    var method: FriendlyURLSession.HTTPMethod {
        switch self {
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
            default:
                break
        }
        
        return parameters
    }
}
