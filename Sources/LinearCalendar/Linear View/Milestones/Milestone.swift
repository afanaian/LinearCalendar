//
//  Milestone.swift
//  
//
//  Created by Alexander Fanaian on 12/5/20.
//

import SwiftUI

struct PointMilestoneShape: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 5))
            path.addLines([
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 5, y: 5)
            ])
            path.closeSubpath()
        }
        .stroke()
    }
}

//struct PointMilestoneShape_Previews: PreviewProvider {
//    static var previews: some View {
//        PointMilestoneShape()
//    }
//}

struct CenterMilestoneView: View {
    
    let text: String = "Eat Ass"
    let includeEdge: Bool = true
    
    var body: some View {
        ZStack {
            PointMilestoneShape()
            
            MilestoneShape(includeEdge: includeEdge)
                .fill(Color.red)
                .frame(width: 50, height: 10)
            
            Text(text)
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

private extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

private struct MilestoneShape: Shape {
    var includeEdge: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        if includeEdge {
            path.addArc(center: CGPoint(x: rect.width, y: rect.height / 2), radius: 5, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct FillMilestoneShape_Previews: PreviewProvider {
    static var previews: some View {
        CenterMilestoneView()
    }
}
