//
//  MilestoneCell.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import SwiftUI
import CoreData

@available(iOS 14.0, *)
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
                        .foregroundColor(linearColors.titleDivider), alignment: .trailing)
            
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

private struct DividerLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.width, y: 10))
        return path
    }
}

@available(iOS 14.0, *)
struct MilestoneCell_Previews: PreviewProvider {
    static var previews: some View {
        let testData = TestData()
        let m01 = MilestoneItem(title: "Test 01", color: .blue, date: Date(), objectId: NSManagedObjectID())
        let m02 = MilestoneItem(title: "Test 02", color: .blue, date: Date(), objectId: NSManagedObjectID())
        let m03 = MilestoneItem(title: "Test 02", color: .red, date: Date(), objectId: NSManagedObjectID())
        
        let milestoneDay = MilestoneDay(date: Date(), milestones: [m01, m02, m03])
        MilestoneDayView(milestoneDay: milestoneDay, linearColors: testData.linearColors)
            .background(Color.gray)
    }
}
#endif
