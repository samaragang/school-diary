//
//  ResponseAccessTokenModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class ResponseAccessTokenModel: Decodable {
    let accessToken: String
    let expireAt   : Int
    
    enum CodingKeys: CodingKey {
        case accessToken
        case expireAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.expireAt = try container.decode(Int.self, forKey: .expireAt)
    }
}
