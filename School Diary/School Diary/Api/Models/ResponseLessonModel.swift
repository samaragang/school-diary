//
//  ResponseLessonModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import Foundation

final class ResponseLessonModel: Decodable {
    let lesson    : String
    let time      : String
    let auditorium: String
    let hometasks : [ResponseHometaskModel]?
    let className : String?
    let classId   : Int?
    let subjectId : Int
    
    enum CodingKeys: String, CodingKey {
        case lesson
        case time
        case auditorium
        case hometasks
        case className = "class"
        case classId
        case subjectId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.lesson = try container.decode(String.self, forKey: .lesson)
        self.time = try container.decode(String.self, forKey: .time)
        self.auditorium = try container.decode(String.self, forKey: .auditorium)
        self.hometasks = try container.decodeIfPresent([ResponseHometaskModel].self, forKey: .hometasks)
        self.className = try container.decodeIfPresent(String.self, forKey: .className)
        self.classId = try container.decodeIfPresent(Int.self, forKey: .classId)
        self.subjectId = try container.decode(Int.self, forKey: .subjectId)
    }
}
