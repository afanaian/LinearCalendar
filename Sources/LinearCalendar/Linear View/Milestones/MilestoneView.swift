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
        ZStack {
            MilestoneShape(includePoint: includePoint, includeEdge: includeEdge)
                .fill(milestone.color)
            
            Text(milestone.title)
                .lineLimit(1)
                .foregroundColor(.white)
                .offset(x: includePoint ? 15 : 0)
        }
        .fixedSize()
    }
}

private struct MilestoneShape: Shape {
    var includePoint: Bool = false
    var includeEdge: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let centerY = rect.height / 2
        var path = Path()
        
        let width = rect.width + (includePoint ? 15 : 0)
        
        // Adds leading triangle if needed
        if includePoint {
            path.move(to: CGPoint(x: 0, y: centerY))
            path.addLine(to: CGPoint(x: 15, y: 0))
        } else {
            path.move(to: CGPoint.zero)
        }
        path.addLine(to: CGPoint(x: width, y: 0))
        
        if includeEdge {
            path.addArc(center: CGPoint(x: width, y: centerY), radius: 10, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
        }
        path.addLine(to: CGPoint(x: width, y: rect.height))
        path.addLine(to: CGPoint(x: includePoint ? 15 : 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct FillMilestoneShape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            let milestoneItem = MilestoneItem(title: "Testing 😶 Night", color: .red, date: Date(), objectId: NSManagedObjectID())
            MilestoneView(milestone: milestoneItem, includePoint: true, includeEdge: true)
                .environment(\.font, .caption)
                .frame(width: milestoneItem.title.widthOfString() + 30, height: 20)
        }
    }
}
