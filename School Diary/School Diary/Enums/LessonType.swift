//
//  LessonType.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit

enum LessonType: String, CaseIterable {
    case lessonInClass = "Классная работа"
    case additionalLesson = "Дополнительное занятие"
    
    func actionState(for type: LessonType?) -> UIAction.State {
        guard let type else { return .off }
        
        return type == self ? .on : .off
    }
}
