//
//  ResponseBaseContentModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import Foundation

final class ResponseBaseContentModel<T>: Decodable where T: Decodable {
    let content: T
    
    enum CodingKeys: CodingKey {
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.content = try container.decode(T.self, forKey: .content)
    }
}
