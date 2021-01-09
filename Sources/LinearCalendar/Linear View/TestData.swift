//
//  TestData.swift
//  LinearCalendarTests
//
//  Created by Alexander Fanaian on 11/7/20.
//
#if os(iOS)

import Foundation
import SwiftUI

@available(iOS 14.0, *)
class TestData: NSObject, LinearProtocol, ObservableObject {
    
    @Published var milestoneDays = [MilestoneDay]()
    var linearColors: LinearColors
        
    override init() {
        let nonWeekendBackground = Color.white
        let nonWeekendLabel = Color.white
        let weekendBackground =  Color.gray
        let weekendLabel = Color.yellow
        let todayLabel = Color.red
        let todayBackground = Color.gray
        let notTodayLabel = Color.gray
        let monthDivider = Color.blue
        let titleSeparator = Color.gray
        
        linearColors = LinearColors(nonWeekendBackground: nonWeekendBackground, weekendBackground: weekendBackground, nonWeekendLabel: nonWeekendLabel, weekendLabel: weekendLabel, notTodayLabel: notTodayLabel, todayLabel: todayLabel, todayBackground: todayBackground, monthDivider: monthDivider, titleSeparator: titleSeparator)
        
        super.init()
        createMilestoneDaysWith()
    }

    private func createMilestoneDaysWith(_ milestones: [MilestoneItem]? = nil) {
        milestoneDays.removeAll()
        
        let calendar = Calendar.current
        let startDate = Date.dateForTodayMinusAYear()
        let endDate = Date.dateForTodayPlusAYear()
        let components = DateComponents(hour: 0, minute: 0, second: 0)
                
        calendar.enumerateDates(startingAfter: startDate, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
            guard let date = date else { stop = true; return; }
            
            if date < endDate {
                let milestoneItems = self.milestones(milestones: milestones, forDay: date)
                let milestoneData = MilestoneDay(date: date, milestones: milestoneItems)
                milestoneDays.append(milestoneData)
            } else {
                stop = true
            }
        }
    }
    
    /**
     Fetches milestones for current day sorted by their color.
     - Parameters:
     - milestones: The number of milestones
     - forDay: Current day
     - Returns: Milestones if they are for the current day sorted by their color
     */
    private func milestones(milestones: [MilestoneItem]?, forDay day: Date) -> [MilestoneItem]? {
        guard let milestones = milestones else { return nil }
        let calendar = Calendar.current
        
        let items = milestones.filter {
            return calendar.isDate($0.date, inSameDayAs: day)
        }.sorted { $0.date > $1.date }
        if items.count == 0 { return nil }
        
        return items
    }
}
#endif
