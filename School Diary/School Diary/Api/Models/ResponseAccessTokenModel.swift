//
//  ResponseAccessTokenModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class ResponseAccessTokenModel: Decodable {
    let accessToken: String
    
    enum CodingKeys: CodingKey {
        case accessToken
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
    }
}
