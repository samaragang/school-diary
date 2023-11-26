//
//  ResponseSignInModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class ResponseSignInModel: Decodable {
    let user: ResponseUserModel
    
    enum CodingKeys: CodingKey {
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.user = try container.decode(ResponseUserModel.self, forKey: .user)
    }
}
