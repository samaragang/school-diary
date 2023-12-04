//
//  ScheduleMenuType.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit

enum ScheduleMenuType {
    case createLesson
    case addMark
    case none
    
    func actionState(for type: ScheduleMenuType) -> UIAction.State {
        return type == self ? .on : .off
    }
}
