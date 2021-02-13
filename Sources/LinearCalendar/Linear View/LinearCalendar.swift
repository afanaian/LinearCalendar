//
//  LinearCalendar.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import CoreData
import SwiftUI

@available(iOS 14.0, *)
public protocol LinearProtocol {
    var milestoneDays: [MilestoneDay] { get set }
    var linearColors: LinearColors { get set }
}

@available(iOS 14.0, *)
public protocol MilestoneDelegate {
    func milestoneTapped(_ id: NSManagedObjectID)
}

@available(iOS 14.0, *)
public struct LinearCalendar: View {
    public var model: LinearProtocol
    var delegate: MilestoneDelegate?
    
    public init(model: LinearProtocol, delegate: MilestoneDelegate? = nil) {
        self.model = model
        self.delegate = delegate
        
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().separatorStyle = .none
    }
    
    public var body: some View {
        ScrollViewReader { scrollView in
            List {
                ForEach(model.milestoneDays, id: \.date) { day in
                    MilestoneDayView(milestoneDay: day, linearColors: model.linearColors, delegate: delegate)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .id(day.date.dateWithoutTime)
                }
            }
            .environment(\.defaultMinListRowHeight, 20)
            .frame(maxHeight: .infinity, alignment: .leading)
            .onAppear() {
                scrollView.scrollTo(Date().dateWithoutTime, anchor: .bottom)
            }
        }
    }
}

@available(iOS 14.0, *)
struct LinearCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let testData = TestData()
        LinearCalendar(model: testData)
            .environment(\.font, .caption)
    }
}

#endif

