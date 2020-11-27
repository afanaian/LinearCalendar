//
//  LinearCalendar.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import CoreData
import SwiftUI

@available(iOS 13.0, *)
public protocol LinearProtocol {
    var milestoneDays: [[MilestoneDay]] { get set }
    var linearColors: LinearColors! { get set } //TODO: fix !
}

@available(iOS 13.0, *)
public protocol MilestoneDelegate {
    func milestoneTapped(_ id: NSManagedObjectID)
}

@available(iOS 13.0, *)
public struct LinearCalendar: View {
    public var model: LinearProtocol
    var delegate: MilestoneDelegate?
    
    public init(model: LinearProtocol, delegate: MilestoneDelegate? = nil) {
        self.model = model
        self.delegate = delegate
    }
    
    public var body: some View {
        List {
            ForEach(model.milestoneDays, id: \.self) { days in
                ForEach(days, id: \.date) { day in
                    MilestoneCell(milestoneDay: day, linearColors: model.linearColors, delegate: delegate)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 20)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onAppear() {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

@available(iOS 13.0, *)
struct LinearCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let testData = TestData()
        LinearCalendar(model: testData)
    }
}

#endif

