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
    
    @Published var milestoneDays = [[MilestoneDay]]()
    var linearColors: LinearColors
    
    var milestoneMonths = [MilestoneMonth]()
    
    override init() {
        let nonWeekendBackground = Color("NonWeekendBackground")
        let nonWeekendLabel = Color("NonWeekendLabel")
        let weekendBackground =  Color("WeekendBackground")
        let weekendLabel = Color("WeekendLabel")
        let todayLabel = Color("TodayLabel")
        let notTodayLabel = Color("NotTodayLabel")
        let monthDivider = Color("MonthDivider")
        let titleSeparator = Color("TitleDivider")
        
        linearColors = LinearColors(nonWeekendBackground: nonWeekendBackground, weekendBackground: weekendBackground, nonWeekendLabel: nonWeekendLabel, weekendLabel: weekendLabel, notTodayLabel: notTodayLabel, todayLabel: todayLabel, monthDivider: monthDivider, titleSeparator: titleSeparator)
        
        super.init()
        createMilestoneDaysWith()
    }

    private func createMilestoneDaysWith(_ milestones: [MilestoneItem]? = nil) {
        var monthArray = [MilestoneDay]()
        let calendar = Calendar.current
        
        let startDate = Date.dateForTodayMinusAYear()
        let endDate = Date.dateForTodayPlusAYear()
        let components = DateComponents(hour: 0, minute: 0, second: 0)
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        var month = dateComponents.month
        
        calendar.enumerateDates(startingAfter: startDate, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
            guard let date = date else { stop = true; return; }
            
            if date < endDate {
                let milestoneItems = self.milestones(milestones: milestones, forDay: date)
                let milestoneData = MilestoneDay(date: date, milestones: milestoneItems)
                
                //Keep adding to current month until we reach the following
                let nextDay = calendar.date(byAdding: .day, value: 1, to: date)!
                let nextDateComponents = calendar.dateComponents([.month], from: nextDay)
                let nextMonth = nextDateComponents.month
                
                monthArray.append(milestoneData)
                
                if month != nextMonth {
                    monthArray.sort()
                    milestoneDays.append(monthArray)
                    
                    let milestoneMonth = monthArray.filter { (milestoneDays) -> Bool in
                        guard let milestones = milestoneDays.milestones else { return false }
                        return milestones.count > 0
                    }.sorted(by: > )
                    
                    if milestoneMonth.count > 0 {
                        //milestoneMonths.append(MilestoneMonth(date: date, milestoneDays: milestoneMonth))
                    }
                    
                    monthArray.removeAll()
                    month = nextMonth
                }
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

@available(iOS 14.0, *)
struct TestData_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

#endif
