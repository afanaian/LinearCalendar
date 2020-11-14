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
    var colors: LinearColors
    
    var body: some View {
        let dayOfWeek = milestoneDay.date.dayOfWeek
        let isWeekend = isWeekendDate(dayOfWeek)
        
        HStack {
            let isToday = milestoneDay.date.isToday
            HStack {
                Text("\(milestoneDay.date.dayOfMonth)")
                    .foregroundColor(isToday ? colors.todayLabel : colors.notTodayLabel)
                    .font(.footnote)
            }
            .frame(width: 20, height: 20)
            .background(isToday ? colors.monthDivider : .clear )
            
            if milestoneDay.milestones != nil {
                MilestoneCollection(milestones: milestoneDay.milestones!)
            } else {
                Spacer()
            }
            
            HStack {
                Text("\(dayOfWeek)")
                    .foregroundColor(isWeekend ? colors.weekendLabel : colors.nonWeekendLabel)
                    .font(.footnote)
                
            }
            .frame(width: 20, height: 20)
        }
        .background(isWeekend ? colors.weekendBackground : colors.nonWeekendBackground)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20, alignment: .leading)
    }
    
    private func isWeekendDate(_ day: String) -> Bool {
        return day == "S"
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
        MilestoneCell(milestoneDay: milestoneDay, colors: testData.colors)
    }
}
#endif
