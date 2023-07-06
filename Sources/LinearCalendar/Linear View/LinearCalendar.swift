//
//  LinearCalendar.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import CoreData
import SwiftUI

@available(iOS 16.0, *)
public protocol LinearProtocol {
    var milestoneDays: [MilestoneDay] { get set }
    var linearColors: LinearColors { get set }
}

@available(iOS 16.0, *)
open class LinearCalendarViewModel: ObservableObject {
    @Published open var milestoneDays = [MilestoneDay]()
    public var linearColors: LinearColors
    
    public init(linearColors: LinearColors) {
        self.linearColors = linearColors
    }
}

@available(iOS 16.0, *)
public protocol MilestoneDelegate {
    func milestoneTapped(_ id: String)
}

@available(iOS 16.0, *)
public struct LinearCalendar: View {
    var model: LinearCalendarViewModel
    var delegate: MilestoneDelegate?
    
    public init(model: LinearCalendarViewModel, delegate: MilestoneDelegate? = nil) {
        self.model = model
        self.delegate = delegate
    }
    
    public var body: some View {
        ScrollViewReader { scrollView in
            List {
                ForEach(model.milestoneDays, id: \.self) { day in
                    MilestoneDayView(milestoneDay: day, linearColors: model.linearColors, delegate: delegate)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .id(day.date.dateWithoutTime)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
            .environment(\.defaultMinListRowHeight, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .onAppear() {
                //TODO: ????
//                scrollView.scrollTo(Date().dateWithoutTime, anchor: .bottom)
            }
        }
    }
}

//@available(iOS 15.0, *)
//struct LinearCalendar_Previews: PreviewProvider {
//    static var previews: some View {
//        let testData = TestData()
//        LinearCalendar(model: testData)
//            .environment(\.font, .caption)
//    }
//}

#endif

