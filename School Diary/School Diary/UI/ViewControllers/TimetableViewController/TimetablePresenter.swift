//
//  TimetablePresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import Foundation

protocol TimetableProtocol {
    var daysCount: Int { get }
    
    func day(at indexPath: IndexPath) -> TimetableDaysType
}

final class TimetablePresenter: TimetableProtocol {
    private let days = TimetableDaysType.allCases
    
    var daysCount: Int {
        return days.count
    }
    
    init() {}
    
    func day(at indexPath: IndexPath) -> TimetableDaysType {
        return self.days[indexPath.item]
    }
}
