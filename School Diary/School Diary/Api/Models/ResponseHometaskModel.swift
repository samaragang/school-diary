//
//  ResponseHometaskModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 29.11.23.
//

import Foundation

final class ResponseHometaskModel: Decodable {
    let onDate: String
    let hometask: String
    
    enum CodingKeys: CodingKey {
        case onDate
        case hometask
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.onDate = try container.decode(String.self, forKey: .onDate)
        self.hometask = try container.decode(String.self, forKey: .hometask)
    }
}
