//
//  MilestoneView.swift
//  
//
//  Created by Alexander Fanaian on 12/5/20.
//

import SwiftUI
import CoreData

struct MilestoneView: View {
    
    let milestone: MilestoneItem
    var includePoint: Bool = false
    var includeEdge: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            MilestoneShape(includePoint: includePoint, includeEdge: includeEdge)
                .fill(milestone.color)
            
            Text(milestone.title)
                .fixedSize()
                .foregroundColor(.white)
                .offset(x: includePoint ? 15 : 0)
        }
    }
}

private struct MilestoneShape: Shape {
    var includePoint: Bool = false
    var includeEdge: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let centerY = rect.height / 2
        var path = Path()
        
        if includePoint {
            path.move(to: CGPoint(x: 0, y: centerY))
            path.addLine(to: CGPoint(x: 15, y: 0))
        } else {
            path.move(to: CGPoint.zero)
        }
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        if includeEdge {
            path.addArc(center: CGPoint(x: rect.width, y: centerY), radius: 10, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: includePoint ? 15 : 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct FillMilestoneShape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            let milestoneItem = MilestoneItem(title: "Testing 😶", color: .red, date: Date(), objectId: NSManagedObjectID())
            MilestoneView(milestone: milestoneItem, includePoint: true, includeEdge: true)
                .environment(\.font, .caption)
                .frame(width: milestoneItem.title.widthOfString() + 30, height: 20)
        }
    }
}
