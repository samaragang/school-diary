//
//  Date+Ext.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import Foundation

extension Date {
    fileprivate static func daysInWeek(for date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)),
              let rangeOfWeek = calendar.range(of: .weekday, in: .weekOfYear, for: startOfWeek)
        else { return [] }
        
        return (rangeOfWeek.lowerBound..<rangeOfWeek.upperBound).compactMap { offset -> Date? in
            return calendar.date(byAdding: .day, value: offset - rangeOfWeek.lowerBound, to: startOfWeek)
        }
    }
    
    static var daysInCurrentWeek: [Date] {
        return self.daysInWeek(for: Date())
    }
    
    static var daysInNextWeek: [Date] {
        guard let nextWeekDay = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()) else { return [] }
        
        return self.daysInWeek(for: nextWeekDay)
    }
    
    fileprivate static func getWeekForLabel(for weekDays: [Date]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        guard let firstDay = weekDays.first,
              let lastDay = weekDays.last
        else { return "" }
        return "\(dateFormatter.string(from: firstDay)) - \(dateFormatter.string(from: lastDay))"
    }
    
    static var currentWeekForLabel: String {
        return self.getWeekForLabel(for: self.daysInCurrentWeek)
    }
    
    static var nextWeekForLabel: String {
        return self.getWeekForLabel(for: self.daysInNextWeek)
    }
}
