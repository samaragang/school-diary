//
//  TimetablePresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import Foundation

protocol TimetableProtocol {
    var daysCount: Int { get }
    var isCurrentWeek: Bool { get set }
    
    func day(at indexPath: IndexPath) -> TimetableDaysType
    func collectionView(didSelectAt indexPath: IndexPath)
}

final class TimetablePresenter: TimetableProtocol {
    private let days = TimetableDaysType.allCases
    
    private var isCurrentWeekPrivate = true
    
    var daysCount: Int {
        return days.count
    }
    
    var isCurrentWeek: Bool {
        get {
            return self.isCurrentWeekPrivate
        }
        set {
            self.isCurrentWeekPrivate = newValue
        }
    }
    
    init() {}
    
    func day(at indexPath: IndexPath) -> TimetableDaysType {
        return self.days[indexPath.item]
    }
    
    func collectionView(didSelectAt indexPath: IndexPath) {
        let day = self.days[indexPath.row]
        MainCoordinator.shared.pushScheduleViewController(
            dayType: day,
            day: Date.day(day, isCurrentWeek: self.isCurrentWeek),
            isCurrentWeek: self.isCurrentWeek
         )
    }
}
