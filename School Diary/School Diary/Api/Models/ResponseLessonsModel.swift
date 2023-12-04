//
//  ResponseLessonsModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import Foundation

final class ResponseLessonsModel: Decodable {
    let lessons: [ResponseLessonModel]
    
    enum CodingKeys: CodingKey {
        case lessons
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lessons = try container.decode([ResponseLessonModel].self, forKey: .lessons)
    }
}
