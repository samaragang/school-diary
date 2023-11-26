//
//  TimetableDaysType.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit

enum TimetableDaysType: CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var title: String {
        switch self {
            case .monday:
                return "ПН"
            case .tuesday:
                return "ВТ"
            case .wednesday:
                return "СР"
            case .thursday:
                return "ЧТ"
            case .friday:
                return "ПТ"
            case .saturday:
                return "СБ"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
            case .monday:
                return UIColor(red: 1, green: 0.412, blue: 0.408, alpha: 1)
            case .tuesday:
                return UIColor(red: 0.478, green: 0.329, blue: 1, alpha: 1)
            case .wednesday:
                return UIColor(red: 0.996, green: 0.561, blue: 0.38, alpha: 1)
            case .thursday:
                return UIColor(red: 0.173, green: 0.761, blue: 1, alpha: 1)
            case .friday:
                return UIColor(red: 0.353, green: 0.396, blue: 1, alpha: 1)
            case .saturday:
                return UIColor(red: 0.588, green: 0.855, blue: 0.271, alpha: 1)
        }
    }
}
