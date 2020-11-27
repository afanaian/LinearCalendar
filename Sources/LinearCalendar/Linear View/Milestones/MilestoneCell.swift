//
//  MilestoneCell.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import SwiftUI
import CoreData

@available(iOS 13.0, *)
struct MilestoneCell: View {
    
    var milestoneDay: MilestoneDay
    var linearColors: LinearColors
    var delegate: MilestoneDelegate?
    
    var body: some View {
        let dayOfWeek = milestoneDay.date.dayOfWeek
        let isWeekend = Calendar.current.isDateInWeekend(milestoneDay.date)
        
        HStack {
            let isToday = milestoneDay.date.isToday
            HStack {
                Text("\(milestoneDay.date.dayOfMonth)")
                    .foregroundColor(isToday ? linearColors.todayLabel : linearColors.notTodayLabel)
                    .font(.footnote)
            }
            .frame(width: 20, height: 20)
            .background(isToday ? linearColors.monthDivider : .clear )
            
            if let milestones = milestoneDay.milestones {
                MilestoneCollection(milestones: milestones, delegate: delegate)
            } else {
                Spacer()
            }
            
            HStack {
                Text("\(dayOfWeek)")
                    .foregroundColor(isWeekend ? linearColors.weekendLabel : linearColors.nonWeekendLabel)
                    .font(.footnote)
                
            }
            .frame(width: 20, height: 20)
        }
        .background(isWeekend ? linearColors.weekendBackground : linearColors.nonWeekendBackground)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20, alignment: .leading)
    }
}

@available(iOS 13.0, *)
struct ScaledBezier: Shape {
    
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 20))
        bezierPath.addLine(to: CGPoint(x: 200, y: 20))
        bezierPath.lineWidth = 1.0
        UIColor.red.setStroke()
        return Path(bezierPath.cgPath)
    }
}

@available(iOS 13.0, *)
struct MilestoneCell_Previews: PreviewProvider {
    static var previews: some View {
        let testData = TestData()
        let m01 = MilestoneItem(title: "Test 01", color: MilestoneColor.blue, date: Date(), objectId: NSManagedObjectID())
        let m02 = MilestoneItem(title: "Test 02", color: MilestoneColor.blue, date: Date(), objectId: NSManagedObjectID())
        let milestoneDay = MilestoneDay(date: Date(), milestones: [m01, m02])
        MilestoneCell(milestoneDay: milestoneDay, linearColors: testData.linearColors)
    }
}
#endif
