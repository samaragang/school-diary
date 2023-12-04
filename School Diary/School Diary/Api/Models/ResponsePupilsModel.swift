//
//  ResponsePupilsModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

class ResponsePupilsModel: Decodable {
    let pupils: [ResponseShortUserInfoModel]
    
    enum CodingKeys: CodingKey {
        case pupils
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     
        self.pupils = try container.decode([ResponseShortUserInfoModel].self, forKey: .pupils)
    }
}
