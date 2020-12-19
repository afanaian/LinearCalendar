//
//  Date.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

import Foundation

extension Date {
    var dateWithoutTime: Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date ?? Date()
    }
    
    func isSameDayAs(_ date: Date) -> Bool {
        if Calendar.current.dateComponents([.day], from: self, to: date).day == 0 {
            return true
        }
        return false
    }
    
    var dayOfMonth: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        let day = components.day
        return day!
    }
    
    var day: Double? {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: self)
        return Double(day!)
    }
    
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var dayYear: String { return Formatter.dayYear.string(from: self) }
    
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: self)
        let index = dayOfWeek.index(dayOfWeek.startIndex, offsetBy: 0)
        return String(dayOfWeek[index])
    }
    
    var isToday: Bool {
        return Calendar.current.isDate(self, inSameDayAs: Date())
    }
    
    func getDayOfMonth() -> Int {
        let calendar = Calendar.current
        let componenets = calendar.dateComponents([.day], from: self)
        return componenets.day ?? 0
    }
    
    func getYear() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    static func dateForTodayMinusAYear() -> Date {
        let today = midnightForDate(Date())
        return Date(timeInterval: -60 * 60 * 24 * 365, since: today)
    }
    
    static func dateForTodayPlusAYear() -> Date {
        let today = midnightForDate(Date())
        return Date(timeInterval: 60 * 60 * 24 * 365, since: today)
    }
    
    static func sameMonthYear(_ date: Date, to: Date) -> Bool {
        let calendar = Calendar.current
        let month = calendar.compare(date, to: to, toGranularity: .month) == .orderedSame
        let year = calendar.compare(date, to: to, toGranularity: .year) == .orderedSame
        return month && year
    }
    
    static func midnightForDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        var todayComponents = calendar.dateComponents([.year, .month, .day], from: date)
        todayComponents.hour = 0
        todayComponents.minute = 0
        todayComponents.second = 0
        
        return calendar.date(from: todayComponents)!
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    
    static let dayYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.d"
        return formatter
    }()
}
