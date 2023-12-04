//
//  ResponseShortUserInfoModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

class ResponseShortUserInfoModel: Decodable {
    let name   : String
    let surname: String
    let userId : Int
    private let markRaw: Int?
    
    var mark: MarkType {
        return MarkType(rawValue: "\(self.markRaw ?? 0)") ?? .none
    }
    
    var nameAndSurname: String {
        return "\(surname) \(name)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case userId
        case markRaw = "mark"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.markRaw = try container.decodeIfPresent(Int.self, forKey: .markRaw)
    }
}
