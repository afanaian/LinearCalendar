//
//  MilestoneCollection.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//
#if os(iOS)

import SwiftUI
import CoreData

@available(iOS 15.0, *)
struct MilestoneCollection: View {
    
    var milestones: [MilestoneItem]
    var delegate: MilestoneDelegate?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(milestones.indices, id: \.self) { index in
                    let milestone = milestones[index]
                    let includePoint: Bool = index == 0
                    let includeEdge: Bool = index == milestones.endIndex.advanced(by: -1)

                    Button(action: {
                        delegate?.milestoneTapped(milestone.id)
                    }) {
                        MilestoneView(milestone: milestone, includePoint: includePoint, includeEdge: includeEdge)
                    }
                    .offset(x: includePoint ? 0 : 15)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(height: 20)
        }
    }
}

extension String {
    func widthOfString() -> CGFloat {
        let attributes = [NSAttributedString.Key.font : self]
        let attString = NSAttributedString(string: self, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(), nil, CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), nil).width
    }
}

@available(iOS 15.0, *)
struct MilestoneCollection_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            MilestoneItem(title: "Test 😶 disgrace", color: .blue, date: Date(), objectId: NSManagedObjectID()),
            MilestoneItem(title: "Test2", color: .blue, date: Date(), objectId: NSManagedObjectID())
        ]
        MilestoneCollection(milestones: items)
            .environment(\.font, .caption)

    }
}

#endif
