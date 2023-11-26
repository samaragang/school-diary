//
//  ResponseTeacherInfoModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import Foundation

final class ResponseTeacherInfoModel: Decodable {
    let teacherInfo: ResponseUserBaseModel
    
    enum CodingKeys: CodingKey {
        case teacherInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.teacherInfo = try container.decode(ResponseUserBaseModel.self, forKey: .teacherInfo)
    }
}
