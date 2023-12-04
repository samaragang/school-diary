//
//  MarkType.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit

enum MarkType: String, CaseIterable {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case none = "-"
    
    var color: UIColor? {
        switch self {
            case .one:
                return UIColor(red: 1, green: 0.41, blue: 0.41, alpha: 1)
            case .two:
                return UIColor(red: 1, green: 0.59, blue: 0.41, alpha: 1)
            case .three:
                return UIColor(red: 1, green: 0.69, blue: 0.41, alpha: 1)
            case .four:
                return UIColor(red: 1, green: 0.87, blue: 0.41, alpha: 1)
            case .five:
                return UIColor(red: 0.7, green: 0.31, blue: 1, alpha: 1)
            case .six:
                return UIColor(red: 0.47, green: 0.31, blue: 1, alpha: 1)
            case .seven:
                return UIColor(red: 0.36, green: 0.47, blue: 1, alpha: 1)
            case .eight:
                return UIColor(red: 0.17, green: 0.76, blue: 1, alpha: 1)
            case .nine:
                return UIColor(red: 0.59, green: 0.85, blue: 0.27, alpha: 1)
            case .ten:
                return UIColor(red: 0.27, green: 0.85, blue: 0.64, alpha: 1)
            case .none:
                return nil
        }
    }
    
    static var allCasesWithoutZero: [MarkType] {
        var marks = self.allCases
        marks.removeLast()
        return marks
    }
}
