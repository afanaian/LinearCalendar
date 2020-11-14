//
//  TestData.swift
//  LinearCalendarTests
//
//  Created by Alexander Fanaian on 11/7/20.
//
#if os(iOS)

import Foundation
import SwiftUI

@available(iOS 13.0, *)
class TestData: LinearProtocol, ObservableObject {
    
    @Published var milestoneDays = [[MilestoneDay]]()
    var colors: LinearColors!
    
    var milestoneMonths = [MilestoneMonth]()
    
    init() {
        colors = createColors()
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
    
    private func createColors() -> LinearColors {
        let lightBlack = Color(red: 30/255, green: 30/255, blue: 30/255, opacity: 1.0)
        let nonWeekendLabel = Color(red: 103/255, green: 118/255, blue: 125/255, opacity: 1.0)
        let weekendBackground =  Color(red: 36/255, green: 42/255, blue: 45/255, opacity: 1.0)
        let weekendLabel = Color(red: 147/255, green: 169/255, blue: 180/255, opacity: 1.0)
        let lightGray = Color(red: 204/255, green: 210/255, blue: 210/255, opacity: 1.0)
        let todayLabel = Color(red: 52/255, green: 72/255, blue: 81/255, opacity: 1.0)
        let monthDivider = Color(red: 121.0/255.0, green: 202.0/255.0, blue: 206.0/255.0, opacity: 1.0)
        let titleSeparator = Color(red: 52.0/255.0, green: 72.0/255.0, blue: 81.0/255.0, opacity: 1.0)
        
        return LinearColors(nonWeekendBackground: lightBlack, weekendBackground: weekendBackground, nonWeekendLabel: nonWeekendLabel, weekendLabel: weekendLabel, notTodayLabel: lightGray, todayLabel: todayLabel, monthDivider: monthDivider, titleSeparator: titleSeparator)
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
        }.sorted { $0.color.rawValue > $1.color.rawValue }
        if items.count == 0 { return nil }
        
        return items
    }
}

@available(iOS 13.0, *)
struct TestData_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

#endif
