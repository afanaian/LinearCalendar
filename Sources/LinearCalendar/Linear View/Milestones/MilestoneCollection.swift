//
//  MilestoneCollection.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//
#if os(iOS)

import SwiftUI
import CoreData

@available(iOS 13.0, *)
struct MilestoneCollection: View {
    
    var milestones: [MilestoneItem]
    var delegate: MilestoneDelegate?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 0) {
                ForEach(milestones) { milestone in
                    Button(action: {
                        delegate?.milestoneTapped(milestone.id)
                    }) {
                        CollectionTitle(text: "\(milestone.title)")
                    }
                    .background(milestoneImageForColor(milestone.color))
                }
            }
        }
    }
    
    private func milestoneImageForColor(_ milestoneColor: MilestoneColor) -> Image {
        return milestoneColor.image.resizable(capInsets: EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 15), resizingMode: .stretch)
    }
}

@available(iOS 13.0, *)
struct CollectionTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(.white)
            .background(Color.clear)
            .offset(x: 10)
    }
}

@available(iOS 13.0, *)
struct MilestoneCollection_Previews: PreviewProvider {
    static var previews: some View {
        let milestones = [MilestoneItem(title: "Test 01", color: MilestoneColor.blue, date: Date(), objectId: NSManagedObjectID())]
        MilestoneCollection(milestones: milestones)
    }
}

#endif
