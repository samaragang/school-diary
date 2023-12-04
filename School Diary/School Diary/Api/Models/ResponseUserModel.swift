//
//  ResponseUserModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class ResponseUserModel: ResponseUserBaseModel {
    fileprivate let roleRawValue: Int
    
    let accessToken: ResponseAccessTokenModel
    
    var role: RoleType {
        return RoleType(rawValue: self.roleRawValue) ?? .none
    }
    
    enum CodingKeys: String, CodingKey {
        case roleRawValue = "role"
        case accessToken
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.roleRawValue = try container.decode(Int.self, forKey: .roleRawValue)
        self.accessToken = try container.decode(ResponseAccessTokenModel.self, forKey: .accessToken)
        
        try super.init(from: decoder)
    }
}
