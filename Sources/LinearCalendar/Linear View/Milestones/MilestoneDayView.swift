//
//  MilestoneCell.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import SwiftUI
import CoreData

@available(iOS 15.0, *)
struct MilestoneDayView: View {
    
    var milestoneDay: MilestoneDay
    var linearColors: LinearColors
    var delegate: MilestoneDelegate?
    
    var body: some View {
        let dayOfWeek = milestoneDay.date.dayOfWeek
        let isWeekend = Calendar.current.isDateInWeekend(milestoneDay.date)
        let newMonth = milestoneDay.date.dayOfMonth == 1
        let dividerColor = newMonth ? linearColors.monthDivider : linearColors.weekendBackground
        
        HStack(alignment: .center, spacing: 0) {
            let isToday = milestoneDay.date.isToday
            
            Text(String(milestoneDay.date.dayOfMonth))
                .foregroundColor(isToday ? linearColors.todayLabel : linearColors.nonWeekendLabel)
                .font(.footnote)
                .frame(width: 20, height: 20)
                .background(isToday ? linearColors.todayBackground : .clear )
                .overlay(
                    Rectangle()
                        .frame(width: 1, alignment: .trailing)
                        .foregroundColor(linearColors.titleDivider), alignment: .trailing
                )
            
            if let milestones = milestoneDay.milestones {
                MilestoneCollection(milestones: milestones, delegate: delegate)
            } else {
                Spacer()
            }
            
            Text(dayOfWeek)
                .foregroundColor(isWeekend ? linearColors.weekendLabel : linearColors.nonWeekendLabel)
                .font(.footnote)
                .frame(width: 20, height: 20)
        }
        .background(isWeekend ? linearColors.weekendBackground : linearColors.nonWeekendBackground)
        .overlay(
            Rectangle()
                .frame(height: 1, alignment: .trailing)
                .foregroundColor(dividerColor), alignment: .top
        )
    }
}

@available(iOS 15.0, *)
struct MilestoneCell_Previews: PreviewProvider {
    static var previews: some View {
        let testData = TestData()
        let milestones = [
            MilestoneItem(title: "Test 01", color: .blue, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 02", color: .blue, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 03", color: .red, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 04", color: .red, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 05", color: .red, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 06", color: .red, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 07", color: .red, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test 08", color: .red, date: Date(), objectId: NSManagedObjectID())
        ]

        let milestoneDay = MilestoneDay(date: Date(), milestones: milestones)
        MilestoneDayView(milestoneDay: milestoneDay, linearColors: testData.linearColors)
            .background(Color.gray)
    }
}
#endif
