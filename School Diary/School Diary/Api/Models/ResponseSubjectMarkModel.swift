//
//  ResponseSubjectMarkModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

final class ResponseSubjectMarkModel: Decodable {
    private let marksRaw: [Int]
    
    let subjectName: String
    let averageMark: Double?
    
    var marks: String {
        return self.marksRaw.map({ "\($0)" }).joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case subjectName
        case marksRaw = "marks"
        case averageMark
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.subjectName = try container.decode(String.self, forKey: .subjectName)
        self.marksRaw = try container.decode([Int].self, forKey: .marksRaw)
        self.averageMark = try container.decodeIfPresent(Double.self, forKey: .averageMark)
    }
}
