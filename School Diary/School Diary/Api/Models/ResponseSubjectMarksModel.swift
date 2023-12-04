//
//  ResponseSubjectMarksModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

final class ResponseSubjectMarksModel: Decodable {
    let subjects: [ResponseSubjectMarkModel]
    
    enum CodingKeys: CodingKey {
        case subjects
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.subjects = try container.decode([ResponseSubjectMarkModel].self, forKey: .subjects)
    }
}
