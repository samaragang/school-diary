//
//  ResponseUserBaseModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import Foundation

class ResponseUserBaseModel: Decodable {
    let name       : String
    let surname    : String
    let schoolId   : Int
    let userId     : Int
    let classId    : Int
    let phoneNumber: String
    
    var nameAndSurname: String {
        return "\(name) \(surname)"
    }
    
    enum CodingKeys: CodingKey {
        case name
        case surname
        case schoolId
        case userId
        case classId
        case phoneNumber
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.schoolId = try container.decode(Int.self, forKey: .schoolId)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.classId = try container.decode(Int.self, forKey: .classId)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
    }
}
