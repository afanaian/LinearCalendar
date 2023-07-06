//
//  MilestoneView.swift
//  
//
//  Created by Alexander Fanaian on 12/5/20.
//

import SwiftUI
import CoreData

@available(iOS 15.0, *)
// Had to do each portion individually.
// For some reason the sizing for the point / edge doesn't totally match up when you make them in one shape.
struct MilestoneView: View {
    
    let milestone: MilestoneItem
    var includePoint: Bool = false
    var includeEdge: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if includePoint {
                MilestonePoint(fillColor: milestone.color)
                    .frame(width: 15, height: 20)
            }
            
            Text(milestone.title)
                .lineLimit(1)
                .foregroundColor(.white)
                .background(
                    Rectangle()
                        .fill(milestone.color)
                )
            
            if includeEdge {
                MilestoneEdge(fillColor: milestone.color)
            }
        }
    }
}

private struct MilestonePoint: View {
    var fillColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            let midY = geometry.size.height / 2
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: midY))
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                path.closeSubpath()
            }
            .fill(fillColor)
        }
    }
}

private struct MilestoneEdge: View {
    var fillColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.addArc(center: CGPoint(x: 0, y: geometry.size.height / 2), radius: geometry.size.height / 2, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
            }
            .fill(fillColor)
        }
    }
}

@available(iOS 15.0, *)
struct FillMilestoneShape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            let milestoneItem = MilestoneItem(id: UUID().uuidString, title: "Testing 😶 Night", color: .red, date: Date())
            MilestoneView(milestone: milestoneItem, includePoint: true, includeEdge: true)
                .environment(\.font, .caption)
                .frame(width: milestoneItem.title.widthOfString() + 30, height: 20)
        }
    }
}
